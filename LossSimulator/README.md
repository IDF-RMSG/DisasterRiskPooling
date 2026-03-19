Loss Simulator
===============

Part of the Disaster Risk Pooling Tool: https://github.com/IDF-RMSG/DisasterRiskPooling/

This folder contains code for an R-Shiny interface, as part of the Disaster Risk Pooling Tool, which enables users to pull data from online historical 
disaster loss catalogues, trend them according to changes in population, inflation and GDP, then export modelled loss curves for use in the Risk Pool Structuring 
tool (see folder 'RiskPoolStructuring'). This app is based on an original tool by the World Bank Group.

The Loss Simulator is available to run online at: https://idf-rmsg.shinyapps.io/DisasterRiskPooling

To run the LossSimulator locally, download this folder and run LossSimulator/app.R
In addition to installing packages contained within the code, first install package 'qpcR', available in /LossSimulator/Rpackages