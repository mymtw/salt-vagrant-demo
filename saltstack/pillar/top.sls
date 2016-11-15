dev:  
  'minion1': 
    - dev.backend

qa:
  # minion1 should be another in fight, currently this need just for test deploy for different envs
  'minion1':
    - qa.backend
