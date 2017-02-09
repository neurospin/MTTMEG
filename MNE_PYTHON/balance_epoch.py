# -*- coding: utf-8 -*-
"""
Created on Mon Jan 18 14:31:39 2016

@author: bgauthie
"""
import numpy as np

def balance_epoch(epochs, condcomb, datasource):    
     
    # modify event code to get task+ref code
    events = epochs.events
    events = np.int32(events[:,2]/10) - np.int32(events[:,2]/1000)*100;     
     
    # for each cond
    index = []
    for c,cond in enumerate(condcomb):   
        
        # define correspondance between condition adn new simplified eventcode
        if datasource[c] == 'EVT' or datasource[c] == 'EVS':
            DIMREFcode = {'EtPast':(8,), 'EtPre':(6,), 'EtFut':(10,), 'EtWest':(12,), 'EtEast':(14,),
                          'EsPast':(9,), 'EsPar':(7,), 'EsFut':(11,), 'EsWest':(13,), 'EsEast':(15,),
                          'EtAll':(6,8,10,12,14), 'EsAll':(7,9,11,13,15)}    
        elif datasource[c] == 'QTT' or datasource[c] == 'QTS': 
            DIMREFcode = {'QtPast':(8,), 'QtPre':(6,), 'QtFut':(10,), 'QtWest':(12,), 'QtEast':(14,),
                          'QsPast':(9,), 'QsPar':(7,), 'QsFut':(11,), 'QsWest':(13,), 'QsEast':(15,),
                          'QtAll':(6,8,10,12,14), 'QsAll':(7,9,11,13,15)}   
        
        # get index of events corresponding to eache eventcode
        neweventcode = DIMREFcode[cond]
        index_for_cond = []
        for eve in neweventcode:
            index_for_cond.append(np.where(events == eve))
        index.append(index_for_cond)
        
        
        
        
        
    
    