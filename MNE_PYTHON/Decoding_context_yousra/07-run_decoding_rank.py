"""
Plot decoding for V or AV - pretest or posttest:
All levels of coherence using evoked in sensor space
"""

import os
import numpy as np
from scipy import io
from scipy.interpolate import interp1d

import matplotlib.pyplot as plt
import matplotlib

from sklearn.linear_model import Ridge
from sklearn.cross_validation import cross_val_score, StratifiedShuffleSplit

import mne
from mne.minimum_norm import apply_inverse_epochs, read_inverse_operator
from mne.label import read_labels_from_annot

import itertools

from config import get_inputs, correlation_matrix

# Choose which group and which condition
g, s, c, l = get_inputs(group=False, subject=False, condition=True,
                        label_name=False)

condition = c[0]  # pretest
# condition = c[1]  # posttest
condi = condition[:-4]

# Decoding for all levels of coherence
event_id = dict(level_1=1, level_2=2, level_3=3, level_4=4, level_5=5,
                level_6=6, level_7=7)
tmin, tmax = 0.100, 0.600

# windows = [(-0.1, 0.), (-0.05,0.05), (0,0.1), (0.05,0.15), (0.1,0.2),
#            (0.15,0.25), (0.2,0.3), (0.25,0.35), (0.3,0.4), (0.35,0.45),
#            (0.4,0.5), (0.45,0.55), (0.5,0.6)]

windows = [(-0.1, 0.), (0, 0.1), (0., 0.15), (0., 0.2), (0., 0.25),
           (0., 0.3), (0., 0.35), (0., 0.4), (0., 0.45), (0., 0.5),
           (0., 0.55), (0., 0.6)]

windows = [(-0.1, 0), (0.1, 0.2), (0.1, 0.25), (0.1, 0.3), (0.1, 0.35),
           (0.1, 0.4), (0.1, 0.45), (0.1, 0.55), (0.1, 0.6)]

windows = [(0.1, .6)]

import sys
if len(sys.argv) > 1:
    window_idx = int(sys.argv[1])
    tmin, tmax = windows[window_idx]


study_path = os.path.abspath(os.curdir)
subjects_dir = study_path + '/subjects/'

# inverse param in case decoding is done in source space
snr = 3.0
lambda2 = 1.0 / snr ** 2
method = 'dSPM'


def rank_scorer(clf, X, y):
    y_pred = clf.predict(X)
    comb = itertools.combinations(range(len(y)), 2)
    k = 0
    score = 0.

    for i, j in comb:
        if y[i] == y[j]:
            continue
        score += np.sign((y[i] - y[j]) * (y_pred[i] - y_pred[j])) > 0.
        confusion[y[i] - 1, y[j] - 1] += np.sign((y[i] - y[j]) *
                                                 (y_pred[i] - y_pred[j])) > 0.
        confusion[y[j] - 1, y[i] - 1] += np.sign((y[i] - y[j]) *
                                                 (y_pred[i] - y_pred[j])) > 0.
        count[y[i] - 1, y[j] - 1] += 1
        count[y[j] - 1, y[i] - 1] += 1
        k += 1

    return score / float(k)

scores = dict()
std_scores = dict()
confusion_all = dict()
confusion_avg = dict()
behavior_all = dict()
behavior_avg = dict()
behavior_thresh_avg = dict()
count_all = dict()

sensor_space = True
sensor_space = False

for (tmin, tmax) in windows:
    for group in g:
        scores[group] = np.zeros((len(s[group]), 7, 7))
        std_scores[group] = np.zeros((len(s[group]), 7, 7))

        confusion_all[group] = np.zeros((len(s[group]), 7, 7))
        confusion_avg[group] = np.zeros((7, 7))
        count_all[group] = np.zeros((len(s[group]), 7, 7))
        behavior_all[group] = np.zeros((len(s[group]), 7))
        behavior_avg[group] = np.zeros(7)
        behavior_thresh_avg[group] = 0.

        for j, subject in enumerate(s[group]):
            print "Processing %s" % subject

            data_path = study_path + '/MEG/' + group + '/' + subject

            # from mne.selection import read_selection
            # name = 'occipital'
            # selection = read_selection(name=name)
            # selection = [
            #    n.replace(' ', '') if ' ' in n else n for n in selection]

            # Read epochs
            epochs_fname = data_path + '/%s_trans_sss_ds8-epo.fif' % condition
            epochs = mne.read_epochs(epochs_fname)
            epochs = epochs.crop(tmin, tmax)

            epochs_list = [epochs[k] for k in sorted(event_id.keys())]
            mne.epochs.equalize_epoch_counts(epochs_list)

            ##################################################################
            # Decoding in sensor space using a linear SVM
            n_times = len(epochs.times)

            if sensor_space:  # run sensor space
                postfix = ""
                # Take only the gradiometers
                data_picks = mne.pick_types(epochs.info, meg='grad',
                                            exclude='bads')

                # Make arrays X and y such that :
                # X is 3d with X.shape[0] is the total number of
                # epochs to classify
                # y is filled with integers coding for the class to predict
                # We must have X.shape[0] equal to y.shape[0]
                X = [e.get_data()[:, data_picks, :] for e in epochs_list]
                y = [k * np.ones(len(this_X)) for k, this_X in enumerate(X, 1)]
                X = np.concatenate(X)
                X = X.reshape(X.shape[0], X.shape[1] * X.shape[2])

                X /= X.std()
            else:
                # label_name = 'MT'
                # label_name = 'VLPFC'
                # label_name = 'pSTS'
                # label_name = 'mSTS'
                # label_name = 'ITC'
                # label_name = 'FEF'
                # label_name = 'frontalpole'
                # label_name = 'V4'
                label_name = 'V1_V2'
                # label_name = 'AC'
                # labels, label_colors = mne.labels_from_parc('fsaverage',
                #                                             parc='aparc',
                #                                             subjects_dir=subjects_dir)

                postfix = "_%s" % label_name
                fname_inv = data_path + '/trans_sss_filt-2-45_ds8_meg-oct-6-inv.fif'

                inverse_operator = read_inverse_operator(fname_inv)
                if label_name == 'frontalpole':
                    labels = read_labels_from_annot(subject, parc='aparc.split'
                                                    '-small', hemi='both',
                                                    subjects_dir=subjects_dir,
                                                    regexp=label_name)
                    label = labels[0] + labels[1]
                else:
                    rh_label = mne.read_label(data_path + '/individual/'
                                              '%s-rh.label' % label_name)
                    # label = rh_label
                    lh_label = mne.read_label(data_path + '/individual/'
                                              '%s-lh.label' % label_name)
                    label = lh_label + rh_label

                    label_names = []
                    for label_name in label_names:
                        rh_label = mne.read_label(data_path + '/individual/'
                                                  '%s-rh.label' % label_name)
                        lh_label = mne.read_label(data_path + '/individual/'
                                                  '%s-lh.label' % label_name)
                        label = label + lh_label + rh_label
                        postfix = postfix + label_name

                stcs = [apply_inverse_epochs(e, inverse_operator, lambda2,
                                             method, pick_ori='normal',
                                             label=label)
                        for e in epochs_list]

                y = [k * np.ones(len(this_stc)) for k, this_stc in enumerate(stcs, 1)]
                X = np.array([ss.data.ravel() for this_stcs in stcs for ss in this_stcs])

            y = np.concatenate(y).astype(np.int)

            rng = np.random.RandomState(42)
            order = np.argsort(rng.randn(len(y)))
            y = y[order]
            X = X[order]

            subject_behavior = subject.split('_')[0]
            subject_behavior = subject_behavior[:2] + '_' + subject_behavior[2:]
            behavior = io.loadmat(study_path +
                                  '/MEG/behavior/%s/%s/Analyses.mat'
                                  % (group, subject_behavior))
            behavior_all[group][j] = behavior['%s_perf' % condi][:, 0]
            behavior_avg[group] += behavior_all[group][j]
            behavior_thresh_avg[group] += behavior['%s_threshold' % condi][0][0]

            clf = Ridge(alpha=1e3)
            cv = StratifiedShuffleSplit(y, 10, test_size=0.2, random_state=0)

            # Run cross-validation
            count = np.zeros((7, 7))
            confusion = np.zeros((7, 7))
            scores_t = cross_val_score(clf, X, y, cv=cv, scoring=rank_scorer)

            scores[group][j] = scores_t.mean()
            std_scores[group][j] = scores_t.std()

            count_all[group][j] = count
            confusion_all[group][j] = confusion / count
            confusion_avg[group] += confusion_all[group][j]

        confusion_avg[group] /= len(s[group])
        behavior_avg[group] /= len(s[group])
        behavior_thresh_avg[group] *= 100. / len(s[group])

    window = "_%s_%s" % (tmin, tmax)

    np.save(study_path + '/confusions/confusions_%s%s%s.npy'
            % (condition, postfix, window),
            np.concatenate([confusion_all[group] for group in g], axis=0))
    np.save(study_path + '/confusions/behaviors_all_%s.npy' % condition,
            np.concatenate([behavior_all[group] for group in g], axis=0))
    np.save(study_path + '/confusions/count_all_%s_scorer%s.npy'
            % (condition, postfix),
            np.concatenate([count_all[group] for group in g], axis=0))


matplotlib.rc('xtick', labelsize=16)
matplotlib.rc('ytick', labelsize=16)


def plot_level(ax1, ax2, level, threshold, n_coh):
    f = interp1d(n_coh, 0.5 + np.arange(7))
    ynew = f(threshold)
    ax1.axvline(ynew, color='k', linewidth=3, linestyle='--')

    f = interp1d(n_coh, range(7))
    ynew = f(level)
    ax2.axvline(ynew, color='k', linewidth=3, linestyle='--')


def plot_confusion(confusion, behavior_curve, level, caption=''):
    extent = [0, 7, 0, 7]
    n_coh = [15, 25, 35, 45, 55, 75, 95]

    threshold = correlation_matrix(confusion.reshape(49))
    plt.figure(figsize=(7, 8))
    ax1 = plt.subplot2grid((3, 10), (0, 0), colspan=9, rowspan=2)
    im = plt.imshow(confusion, extent=extent, aspect='auto',
                    vmin=vmin, vmax=vmax, interpolation='nearest',
                    cmap=plt.cm.Reds)
    plt.title('Confusion matrix - sensors \n%.3fs to %.3fs: '
              '%s \n& behaviors averaged over subjects' %
              (tmin, tmax, caption))

    ax2 = plt.subplot2grid((3, 10), (2, 0), colspan=9, rowspan=1)
    ax3 = plt.subplot2grid((3, 10), (0, 9), colspan=1, rowspan=3)

    ax1.axis('auto')
    ax1.axis('tight')
    ax1.set_xticks([])
    ax1.set_xticklabels([])
    ax1.set_yticks(np.arange(7) + 0.5)
    ax1.set_yticklabels(['%d %%' % c for c in n_coh[::-1]])

    ax2.plot(range(7), behavior_curve, 'rs-', linewidth=2)
    ax2.set_xlim([-0.5, 6.5])
    ax2.set_ylim([0.5, 1])
    ax2.set_xticks(np.arange(7))
    ax2.set_xticklabels(['%d %%' % c for c in n_coh])
    ax2.grid('on')

    plot_level(ax1, ax2, level=level, threshold=threshold, n_coh=n_coh)

    plt.colorbar(im, cax=ax3)
    # plt.tight_layout()

plt.close('all')

vmin, vmax = 0.5, 0.65

confusion_gavg = 0.
behavior_gavg = 0.
behavior_thresh_gavg = 0.

for group in g:
    confusion_gavg += confusion_avg[group]
    behavior_gavg += behavior_avg[group]
    behavior_thresh_gavg += behavior_thresh_avg[group]
    plot_confusion(confusion_avg[group], behavior_avg[group],
                   behavior_thresh_avg[group],
                   caption='%s - %s' % (group, condition))

confusion_gavg /= len(g)
behavior_gavg /= len(g)
behavior_thresh_gavg /= len(g)

plot_confusion(confusion_gavg, behavior_gavg,
               behavior_thresh_gavg,
               caption=condition)

# plt.show()
