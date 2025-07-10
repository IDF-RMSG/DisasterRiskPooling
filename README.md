# The Disaster Risk Pooling Tool

         
It introduces how to model and structure a crisis and disaster risk pool for a fund covering multiple hazards (e.g., floods, droughts, earthquakes).

The central purpose of the Disaster Risk Pooling Tool is educational, serving as an introduction to simulating loss curves from historical loss data (in the Loss Simulator tool) and the considerations that go into developing risk pools (Risk Pool Structuring tool).

The tools have been developed by Maximum Information on behalf of the Insurance Development Forum (IDF) Risk Modelling Steering Group (RMSG) and the World Bank Group's Finance, Competitiveness and Investment team. It is based on the existing 'Financial Risk Assessment Tool' developed by the World Bank for capacity building of their clients. IDF RMSG are responsible for the update of the Loss Simulator.



The Disaster Risk Pooling Tool comprises:
-----------------------------------------------
1. **Step-by-step user guide** (branch 'gh-pages'): https://idf-rmsg.github.io/DisasterRiskPooling/. This guide should be read before using any of the tools.
2. **Loss Simulator**: An R-Shiny interface which enables users to pull data from online historical disaster loss catalogues, trend them according to population change for example, and then export modelled loss curves for use in the risk pooling spreadsheet in the next step. See folder 'LossSimulator' for the code. This app is deployed at: https://idf-rmsg.shinyapps.io/DisasterRiskPooling
3. **Risk Pool Structuring**: An Excel spreadsheet which ingests losses from the Loss Simulator and can be used to test the effect of different risk pool structures. See folder 'RiskPoolStructuring'.
