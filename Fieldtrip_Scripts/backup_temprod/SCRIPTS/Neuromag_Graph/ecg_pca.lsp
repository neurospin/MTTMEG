;;;
;;; This is a setup file for graph
;;; It builds the saved G widgets and links them in the same way as
;;; they were linked when this file was generated.
;;;
;;; Restore modules
;;;

(require "graphlib")
(require "zooming")
(require "channel-selection")
(require "std-selections-vv")
(require "triplet-ecg")
(require "average")
(require "xplotter")
(require "pca")
(require "ssp")

;;;
;;; Body of the setup 
;;;

(graph-setup (:creator "graph" :version 294 :user nil)


;;;
;;; Restore user parameters
;;;

(setq default-diskfile "file" default-data-source "meg"
ssp-vector-directory "/neurospin/local/neuromag/ssp/" print-display-printer
"papyrus" print-display-whole (quote t) print-display-reverse (quote t)
scroll-delay 1 default-ecg-amp  0.001 default-eog-amp  1e-06 default-eeg-amp
 1e-06 default-meg-amp  3e-11 average-limit 999 average-min-step 300
average-step 512 average-classify (quote nil) average-rejection
(quote nil) average-window (quote nil) average-trigger
(quote (ecg-threshold 0)) average-mode (quote :trigger))

;;;
;;; Create widgets needed
;;;

(require-widgets
(quote
((diskfile "file"
("compress-skips" t "open-hook" nil "directory"
"/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Trans_sss/*" "geometry"
"306x389+383+281" "visibility" 0 "face-y" 210 "face-x" 15))
(plotter "triplet1"
("select-hook"
(eval (append '(sync-selection *this*) triplet-displays)) "move-hook"
(eval (append '(sync-view *this*) triplet-displays)) "offsets" #m(
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 )
( 0.0 ))
 "scales"
#m(
( 2.47062873632e-12 )
( 2.47062873632e-12 )
( 2.47062873632e-12 )
( 2.47062873632e-12 )
( 2.47062873632e-12 )
( 2.47062873632e-12 )
( 2.47062873632e-12 )
( 2.47062873632e-12 )
( 2.47062873632e-12 )
( 2.47062873632e-12 )
( 2.47062873632e-12 )
( 2.47062873632e-12 )
( 2.47062873632e-12 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 )
( 2.99999990128e-11 ))
 "track-end" nil "translate" t "show-scales" nil
"show-x-span" nil "ch-label-space" 0 "tick-interval" -1.0 "show-baselines"
nil "clip-to-port" nil "superpose" nil "selection-length" -1.0
"selection-start"  0.0 "baseline-color" "grey" "highlight" "pink"
"background" "white" "default-color" "black" "default-scale"  40000.0
"max-amount" 1000 "increment" 50 "resolution" 1 "length"  5.0 "point"  0.0
"geometry" "nil" "visibility" 0 "face-y" 210 "face-x" 535))
(plotter "triplet2"
("select-hook"
(eval (append '(sync-selection *this*) triplet-displays)) "move-hook"
(eval (append '(sync-view *this*) triplet-displays)) "offsets" #m(
( 0.0 ))
 "scales"
#m(
( 0.0010000000475 )
( 0.0010000000475 )
( 0.0010000000475 ))
 "track-end" nil "translate" t "show-scales" nil
"show-x-span" nil "ch-label-space" 0 "tick-interval" -1.0 "show-baselines"
nil "clip-to-port" nil "superpose" nil "selection-length" -1.0
"selection-start"  0.0 "baseline-color" "grey" "highlight" "pink"
"background" "white" "default-color" "black" "default-scale"  40000.0
"max-amount" 1000 "increment" 50 "resolution" 1 "length"  5.0 "point"  0.0
"geometry" "nil" "visibility" 0 "face-y" 285 "face-x" 535))
(plotter "triplet3"
("select-hook"
(eval (append '(sync-selection *this*) triplet-displays)) "move-hook"
(eval (append '(sync-view *this*) triplet-displays)) "offsets" #m(
( 0.0 ))
 "scales"
#m(
( 0.0010000000475 )
( 0.0010000000475 )
( 0.0010000000475 ))
 "track-end" nil "translate" t "show-scales" nil
"show-x-span" nil "ch-label-space" 0 "tick-interval" -1.0 "show-baselines"
nil "clip-to-port" nil "superpose" nil "selection-length" -1.0
"selection-start"  0.0 "baseline-color" "grey" "highlight" "pink"
"background" "white" "default-color" "black" "default-scale"  40000.0
"max-amount" 1000 "increment" 50 "resolution" 1 "length"  5.0 "point"  0.0
"geometry" "nil" "visibility" 0 "face-y" 365 "face-x" 675))
(average "average"
("max-average-size" 20000000 "keep" nil "ignore-errors" nil "output-mode"
"average" "do-alternating" nil "do-std-error" nil "do-average" t
"update-freq" 50 "end"  0.40000000596 "start" -0.20000000298 "tag" "MCG"
"dataname" "average" "geometry" "441x565+785+387" "visibility" 0 "face-y"
135 "face-x" 265))
(matrix-source "pca-fields"
("geometry" "nil" "visibility" 0 "face-y" 456 "face-x" 10))
(suppressor "ssp"
("buffer-length" 20000 "geometry" "nil" "visibility" 0 "face-y" 135
"face-x" 475))
(ringbuffer "buffer"
("min-step" 0 "size" 50000000 "geometry" "441x232+706+330" "visibility" 0
"face-y" 210 "face-x" 70))
(pick "ecg"
("ignore" nil "names" ("ECG*") "geometry" "441x426+706+233" "visibility" 0
"face-y" 285 "face-x" 265))
(fft-filter "ecg-filter"
("pass-type" :function "pass-band" (band-pass 1 40 1 1) "restrict" nil
"remove-dc" t "downsample" 1 "size" 2048 "geometry" "441x357+700+194"
"visibility" 0 "face-y" 355 "face-x" 340))
(pick "pick"
("ignore" nil "names"
("MEG[ 221  211  131  111  231  241 1511  141 ]"
"MEG[1621 1611 1521 1541 1531]") "geometry" "441x207+888+223" "visibility" 0
"face-y" 210 "face-x" 265))
(fft-filter "chpi-filter"
("pass-type" :function "pass-band" (low-pass 100 10) "restrict" nil
"remove-dc" t "downsample" 1 "size" 2048 "geometry" "441x357+882+184"
"visibility" 0 "face-y" 210 "face-x" 135))
(unary "ecg-threshold"
("complex" nil "arguments" ( 0.0002) "function" threshold "geometry"
"441x257+832+255" "visibility" 0 "face-y" 355 "face-x" 430))
(command "ave-plotter"
("widget-data" nil "update-hook" (xplotter-show-data *this*)
"deactivate-hook" (kill-xplotter *this*) "activate-hook"
(xplotter *this*) "require-hook" nil "active" t "geometry"
"441x307+1011+0" "visibility" 0 "face-y" 135 "face-x" 535))
(plotter "averages"
("select-hook" nil "move-hook" nil "offsets" #m(
(-0.564414441586 )
(-0.0425317324698 )
( 0.0 ))
 "scales"
#m(
( 5.91281468232e-11 )
( 5.91281468232e-11 )
( 5.91281468232e-11 ))
 "track-end" nil "translate" t "show-scales" nil
"show-x-span" t "ch-label-space" 0 "tick-interval" -1.0 "show-baselines"
nil "clip-to-port" nil "superpose" nil "selection-length" -1.0
"selection-start" -1.0 "baseline-color" "grey" "highlight" "pink"
"background" "white" "default-color" "black" "default-scale"  40000.0
"max-amount" 1000 "increment" 50 "resolution" 1 "length"  999.0 "point"
-200.0 "geometry" "652x557+621+0" "visibility" 1 "face-y" 70 "face-x" 545))
(pick "meg-mags"
("ignore" nil "names" ("MEG*1") "geometry" "441x426+738+513" "visibility" 0
"face-y" 135 "face-x" 345))
(pick "meg-grads"
("ignore" ("MEG*1") "names" ("MEG*") "geometry" "441x426+738+513"
"visibility" 0 "face-y" 70 "face-x" 345))
(linear "timevar"
("geometry" "441x150+738+631" "visibility" 0 "face-y" 70 "face-x" 475))
(selector "to-pca"
("geometry" "441x150+738+652" "visibility" 0 "face-y" 135 "face-x" 415))
(unary "ggdgg"
("complex" nil "arguments" nil "function" fabs "geometry" "551x283+0+45"
"visibility" 0 "face-y" 360 "face-x" 565)))))

;;;
;;; Link widgets
;;;

(link-to (G-widget "triplet1") (G-widget "pick") 0 (G-widget "pick") 1
(G-widget "pick") 2 (G-widget "pick") 3 (G-widget "pick") 4
(G-widget "pick") 5 (G-widget "pick") 6 (G-widget "pick") 7
(G-widget "pick") 8 (G-widget "pick") 9 (G-widget "pick") 10
(G-widget "pick") 11 (G-widget "pick") 12)
(link-to (G-widget "triplet2") (G-widget "ecg") 0)
(link-to (G-widget "triplet3") (G-widget "ggdgg") 0)
(link (G-widget "chpi-filter") (G-widget "average"))
(link (G-widget "to-pca") (G-widget "ssp"))
(link (G-widget "file") (G-widget "buffer"))
(link (G-widget "chpi-filter") (G-widget "ecg"))
(link (G-widget "ecg") (G-widget "ecg-filter"))
(link (G-widget "chpi-filter") (G-widget "pick"))
(link (G-widget "buffer") (G-widget "chpi-filter"))
(link (G-widget "ecg-filter") (G-widget "ecg-threshold"))
(link (G-widget "ssp") (G-widget "ave-plotter"))
(link-to (G-widget "averages") (G-widget "timevar") 0
(G-widget "timevar") 1 (G-widget "timevar") 2)
(link (G-widget "average") (G-widget "meg-mags"))
(link (G-widget "average") (G-widget "meg-grads"))
(link (G-widget "to-pca") (G-widget "timevar"))
(link-to (G-widget "to-pca") (G-widget "meg-grads") 0
(G-widget "meg-grads") 1 (G-widget "meg-grads") 2 (G-widget "meg-grads") 3
(G-widget "meg-grads") 4 (G-widget "meg-grads") 5 (G-widget "meg-grads") 6
(G-widget "meg-grads") 7 (G-widget "meg-grads") 8 (G-widget "meg-grads") 9
(G-widget "meg-grads") 10 (G-widget "meg-grads") 11 (G-widget "meg-grads") 12
(G-widget "meg-grads") 13 (G-widget "meg-grads") 14 (G-widget "meg-grads") 15
(G-widget "meg-grads") 16 (G-widget "meg-grads") 17 (G-widget "meg-grads") 18
(G-widget "meg-grads") 19 (G-widget "meg-grads") 20 (G-widget "meg-grads") 21
(G-widget "meg-grads") 22 (G-widget "meg-grads") 23 (G-widget "meg-grads") 24
(G-widget "meg-grads") 25 (G-widget "meg-grads") 26 (G-widget "meg-grads") 27
(G-widget "meg-grads") 28 (G-widget "meg-grads") 29 (G-widget "meg-grads") 30
(G-widget "meg-grads") 31 (G-widget "meg-grads") 32 (G-widget "meg-grads") 33
(G-widget "meg-grads") 34 (G-widget "meg-grads") 35 (G-widget "meg-grads") 36
(G-widget "meg-grads") 37 (G-widget "meg-grads") 38 (G-widget "meg-grads") 39
(G-widget "meg-grads") 40 (G-widget "meg-grads") 41 (G-widget "meg-grads") 42
(G-widget "meg-grads") 43 (G-widget "meg-grads") 44 (G-widget "meg-grads") 45
(G-widget "meg-grads") 46 (G-widget "meg-grads") 47 (G-widget "meg-grads") 48
(G-widget "meg-grads") 49 (G-widget "meg-grads") 50 (G-widget "meg-grads") 51
(G-widget "meg-grads") 52 (G-widget "meg-grads") 53 (G-widget "meg-grads") 54
(G-widget "meg-grads") 55 (G-widget "meg-grads") 56 (G-widget "meg-grads") 57
(G-widget "meg-grads") 58 (G-widget "meg-grads") 59 (G-widget "meg-grads") 60
(G-widget "meg-grads") 61 (G-widget "meg-grads") 62 (G-widget "meg-grads") 63
(G-widget "meg-grads") 64 (G-widget "meg-grads") 65 (G-widget "meg-grads") 66
(G-widget "meg-grads") 67 (G-widget "meg-grads") 68 (G-widget "meg-grads") 69
(G-widget "meg-grads") 70 (G-widget "meg-grads") 71 (G-widget "meg-grads") 72
(G-widget "meg-grads") 73 (G-widget "meg-grads") 74 (G-widget "meg-grads") 75
(G-widget "meg-grads") 76 (G-widget "meg-grads") 77 (G-widget "meg-grads") 78
(G-widget "meg-grads") 79 (G-widget "meg-grads") 80 (G-widget "meg-grads") 81
(G-widget "meg-grads") 82 (G-widget "meg-grads") 83 (G-widget "meg-grads") 84
(G-widget "meg-grads") 85 (G-widget "meg-grads") 86 (G-widget "meg-grads") 87
(G-widget "meg-grads") 88 (G-widget "meg-grads") 89 (G-widget "meg-grads") 90
(G-widget "meg-grads") 91 (G-widget "meg-grads") 92 (G-widget "meg-grads") 93
(G-widget "meg-grads") 94 (G-widget "meg-grads") 95 (G-widget "meg-grads") 96
(G-widget "meg-grads") 97 (G-widget "meg-grads") 98 (G-widget "meg-grads") 99
(G-widget "meg-grads") 100 (G-widget "meg-grads") 101
(G-widget "meg-grads") 102 (G-widget "meg-grads") 103
(G-widget "meg-grads") 104 (G-widget "meg-grads") 105
(G-widget "meg-grads") 106 (G-widget "meg-grads") 107
(G-widget "meg-grads") 108 (G-widget "meg-grads") 109
(G-widget "meg-grads") 110 (G-widget "meg-grads") 111
(G-widget "meg-grads") 112 (G-widget "meg-grads") 113
(G-widget "meg-grads") 114 (G-widget "meg-grads") 115
(G-widget "meg-grads") 116 (G-widget "meg-grads") 117
(G-widget "meg-grads") 118 (G-widget "meg-grads") 119
(G-widget "meg-grads") 120 (G-widget "meg-grads") 121
(G-widget "meg-grads") 122 (G-widget "meg-grads") 123
(G-widget "meg-grads") 124 (G-widget "meg-grads") 125
(G-widget "meg-grads") 126 (G-widget "meg-grads") 127
(G-widget "meg-grads") 128 (G-widget "meg-grads") 129
(G-widget "meg-grads") 130 (G-widget "meg-grads") 131
(G-widget "meg-grads") 132 (G-widget "meg-grads") 133
(G-widget "meg-grads") 134 (G-widget "meg-grads") 135
(G-widget "meg-grads") 136 (G-widget "meg-grads") 137
(G-widget "meg-grads") 138 (G-widget "meg-grads") 139
(G-widget "meg-grads") 140 (G-widget "meg-grads") 141
(G-widget "meg-grads") 142 (G-widget "meg-grads") 143
(G-widget "meg-grads") 144 (G-widget "meg-grads") 145
(G-widget "meg-grads") 146 (G-widget "meg-grads") 147
(G-widget "meg-grads") 148 (G-widget "meg-grads") 149
(G-widget "meg-grads") 150 (G-widget "meg-grads") 151
(G-widget "meg-grads") 152 (G-widget "meg-grads") 153
(G-widget "meg-grads") 154 (G-widget "meg-grads") 155
(G-widget "meg-grads") 156 (G-widget "meg-grads") 157
(G-widget "meg-grads") 158 (G-widget "meg-grads") 159
(G-widget "meg-grads") 160 (G-widget "meg-grads") 161
(G-widget "meg-grads") 162 (G-widget "meg-grads") 163
(G-widget "meg-grads") 164 (G-widget "meg-grads") 165
(G-widget "meg-grads") 166 (G-widget "meg-grads") 167
(G-widget "meg-grads") 168 (G-widget "meg-grads") 169
(G-widget "meg-grads") 170 (G-widget "meg-grads") 171
(G-widget "meg-grads") 172 (G-widget "meg-grads") 173
(G-widget "meg-grads") 174 (G-widget "meg-grads") 175
(G-widget "meg-grads") 176 (G-widget "meg-grads") 177
(G-widget "meg-grads") 178 (G-widget "meg-grads") 179
(G-widget "meg-grads") 180 (G-widget "meg-grads") 181
(G-widget "meg-grads") 182 (G-widget "meg-grads") 183
(G-widget "meg-grads") 184 (G-widget "meg-grads") 185
(G-widget "meg-grads") 186 (G-widget "meg-grads") 187
(G-widget "meg-grads") 188 (G-widget "meg-grads") 189
(G-widget "meg-grads") 190 (G-widget "meg-grads") 191
(G-widget "meg-grads") 192 (G-widget "meg-grads") 193
(G-widget "meg-grads") 194 (G-widget "meg-grads") 195
(G-widget "meg-grads") 196 (G-widget "meg-grads") 197
(G-widget "meg-grads") 198 (G-widget "meg-grads") 199
(G-widget "meg-grads") 200 (G-widget "meg-grads") 201
(G-widget "meg-grads") 202 (G-widget "meg-grads") 203)
(link (G-widget "ecg-threshold") (G-widget "ggdgg"))
;;
;; Done

)