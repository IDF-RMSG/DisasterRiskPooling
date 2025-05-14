# The Disaster Risk Pooling Tool

The Disaster Risk Pooling Tool is an educational resource developed by the Insurance Development Forum in partnership with Maximum Information and the World Bank Disaster Risk Financing and Insurance Program (DRFIP).

It introduces how to model and structure a crisis and disaster risk pool for a fund covering multiple hazards (e.g., floods, droughts, earthquakes).

The central purpose of the Disaster Risk Pooling Tool is educational, serving as an introduction to the different considerations that go into modelling financial risk within funds. The tool demonstrates how the processes of risk pooling and funding can be structured efficiently and responsibly even with events being highly uncertain year to year.

The tool builds on code originally developed by World Bank DRFIP for supporting World Bank client countries to better understand the risk of losses occurring from disasters, by visualising and historical losses creating exceedance probability curves from historical loss data. The original tool: Financial Risk Assessment Tool (http://149.28.228.221/apps/Tool1/)

The Disaster Risk Pooling Tool comprises:
-----------------------------------------------
1. **Step-by-step user guide** (branch 'gh-pages'): https://idf-rmsg.github.io/DisasterRiskPooling/. This guide should be read before using any of the tools.
2. **Loss Simulator**: An R-Shiny interface which enables users to pull data from online historical disaster loss catalogues, trend them according to population change for example, and then export modelled loss curves for use in the risk pooling spreadsheet in the next step. See folder 'LossSimulator' for the code. This app is deployed at: https://idf-rmsg.shinyapps.io/DisasterRiskPooling
3. **Risk Pool Structuring**: An Excel spreadsheet which ingests losses from the Loss Simulator and can be used to test the effect of different risk pool structures. See folder 'RiskPoolStructuring'.
