# -*- coding: utf-8 -*-
"""
Created on Fri Jul  1 15:47:19 2016

@author: bgauthie
"""

def rm_oneway_3lvl_anova(X):

    import pandas as pd
    import numpy as np
    from scipy import stats
    
    def calc_grandmean(data, columns):
       #Takes a pandas dataframe and calculates the grand mean
       #data = dataframe
       #columns = list of column names with the response variables
    
       gm = np.mean(data[columns].mean())
       return gm
    
    ##For createing example data
    X1 = [6,4,5,1,0,2]
    X2 = [8,5,5,2,1,3]
    X3 = [10,6,5,3,2,4]
    
    df = pd.DataFrame({'Subid':xrange(1, len(X1)+1), 'X1':X1, 'X2':X2, 'X3':X3})
    
    #Grand mean
    grand_mean = calc_grandmean(df, ['X1', 'X2', 'X3'])
    df['Submean'] = df[['X1', 'X2', 'X3']].mean(axis=1)
    column_means = df[['X1', 'X2', 'X3']].mean(axis=0)
    
    n = len(df['Subid'])
    k = len(['X1', 'X2', 'X3'])
    #Degree of Freedom
    ncells = df[['X1','X2','X3']].size
    
    dftotal = ncells - 1
    dfbw = 3 - 1
    dfsbj = len(df['Subid']) - 1
    dfw = dftotal - dfbw
    dferror = dfw - dfsbj
    SSbetween = sum(n*[(m - grand_mean)**2 for m in column_means])
    SSwithin = sum(sum([(df[col] - column_means[i])**2 for i,
                  col in enumerate(df[['X1', 'X2', 'X3']])]))
    SSsubject = sum(k*[(m -grand_mean)**2 for m in df['Submean']])
    SSerror = SSwithin - SSsubject      
    SStotal = SSbetween + SSwithin
    #MSbetween
    msbetween = SSbetween/dfw
    
    #MSerror
    mserror = SSerror/dferror
    
    #F-statistic
    F = msbetween/mserror     
    p_value = stats.f.sf(F, 2, dferror)         

return F, p_value
              
              
              
              