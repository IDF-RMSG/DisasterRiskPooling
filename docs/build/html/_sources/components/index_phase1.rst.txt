.. _phase1_reference-label:

Phase 1: Understanding the nature of the risks
==========================================================

**This phase uses the Loss Curve Generator**, an R-Shiny app located at https://idf-rmsg.shinyapps.io/FinancialRiskPooling to demonstrate how to create disaster loss curves from public historical disaster loss data catalogue, EM-DAT.


.. figure:: ../src_img/guidanceimg/phase1.jpg
  :scale: 25%
  :alt: Phase 1 steps



Step 1: Gather Historical Event Data
---------------------------------------

The very first step is gathering data on past events for the risks you want to include. This includes the perils and which countries were affected, in addition to impact metrics such as people affected or financial costs.


**1.1 Identify which risks (hazard + country) to include:**

  These risks will receive guaranteed coverage if they occur in the future up to a pre agreed level. Example: Zimbabwe – Drought.


**1.2 Build or locate a historical event catalog containing:**

  1. Year
  2. Country
  3. Peril (Hazard)
  4. Losses in US$ (any financial losses need to be converted to USD)

  Data sources could include public loss databases (e.g., EM-DAT), records from local stakeholders, and in-house or external models. Working with local agencies and stakeholders to identify and validate past data on events is key. 



**1.3 Identify possible sources of error:**

  * Gaps in historical records
  * Currency, inflation or misreporting
  * Missing data for smaller events




Guidance
""""""""""""""""""

1. For each country and peril, compile a separate sheet.

2. Compile your event data in an Excel file. A template is provided on `here on the Financial Pooling Tool GitHub <https://github.com/IDF-RMSG/FinancialRiskPooling/blob/develop/DisasterRiskPoolingTool/PoolingTool_UploadTemplate.xlsx>`_ (or `download directly <https://github.com/IDF-RMSG/FinancialRiskPooling/raw/refs/heads/develop/DisasterRiskPoolingTool/PoolingTool_UploadTemplate.xlsx>`_).
   
3. Use an example dataset if you lack your own data. An example of data is provided on `here on the Financial Pooling Tool GitHub <https://github.com/IDF-RMSG/FinancialRiskPooling/blob/develop/DisasterRiskPoolingTool/PoolingTool_UploadExample.xlsx>`_ (or `download directly <https://github.com/IDF-RMSG/FinancialRiskPooling/raw/refs/heads/develop/DisasterRiskPoolingTool/PoolingTool_UploadExample.xlsx>`_).




Key Decision-Making Considerations
""""""""""""""""""""""""""""""""""""""""

**What risks do we want to cover financially and include in our pool?**
What risks you will want to cover will likely be different for all organisations and funds and will be dependent on several factors. This may be looking at the risks and impacts that the country has prioritised. It may include looking at the operational systems that are ready to utilise the money effectively in emergencies. How those country risks are identified will require decision-making criteria on those being prioritised for coverage. 

**What data is good enough to include in our catalogue?**
“Good enough” is a relatively subjective term, so it will be important to have some criteria in which past disaster data is deemed of sufficient quality to be included in your catalogue. In some cases, larger events and hazards, such as earthquakes and cyclones, which have clearer infrastructural-based impacts, may be easier to cross-reference and verify and therefore have more confidence in the loss data. Events like droughts and food security impacts can be more difficult to understand and definitively quantify. There should be clear rationale on why different types and sources of data have been included or excluded from the catalogue. It is important that the depiction of risk is kept as true as possible, without augmentation to a preferred view of risk for financial considerations. This should be done later on within the financial structuring. 

**What are the key instances and likely sources of error and uncertainty in the event data?** 
Knowing what gaps and limitations exist within your base event catalogue will give you indications for each risk when the risk relationship depicted may be over or underestimating the risk due to those limitations. The likely reasons for this are essential to note and identify to help with the later management of uncertainties and basis risk operationally. 



.. admonition:: Fundamental Principle
 
   *Magnitude* refers to how big the event is - (this may be defined by the physical hazards, or the impact and losses - which are not the same), so make sure you know what kind of magnitude the data is showing you. 

   *Frequency* is how often that size magnitude event occurs. High magnitude events happen infrequently and low magnitude events happen more frequently. But the relationship between these variables will be different for each risk, location and circumstances. Understanding that relationship is the fundamental core to strategic risk management. 

   *Climate Change* doesn't impact the day to day occurrences of events, but it does alter this magnitude frequency relationship over the long term. 


Now you have a database of past event information on the risks that you want your risk pool to cover. It will tell you some good information about the magnitude and frequency of those events and the overall likely financial need in total those types of crises may require. However, it will likely need some improvements using statistical techniques. 

This is because, often, we will only have a small snapshot of those relationships and patterns, so we need ways to try to understand the broader relationship beyond the data we have for recorded events. The original dataset likely won't cover all potential events of interest (i.e. even rare ones that may occur once every 200 years) and therefore statistical techniques are used instead to re[resent what we can't see with our limited view. 



.. figure:: ../src_img/guidanceimg/stochasticCat.png
  :scale: 25%
  :alt: Schematic of our limited set of observations of events.
  
  Limited duration of event observation (boxed), and extension of that via stochastic simulation.





Step 2: Creating a Synthetic (Stochastic) Catalogue
------------------------------------------------------

This step is about how we take all that information and try to project and understand more deeply the statistical patterns and likely probabilities of different events overall – this uses the tool to support creating a set of synthetic (or stochastic) events. This will generate from a relatively smaller number of event entries into tens of thousands of variations and extremes.

Because we want to understand the long-term pattern of impacts and losses from the hazards, it is often difficult to do this when we only have a short timeline in which we have data on past events; in some cases, we might only have two or three events with good data on impacts and losses. However, to address this, we create a stochastic or synthesised catalogue. This essentially uses the pattern of the data on events available to simulate the loss of other statistically possible events from that data, creating tens of thousands of synthetic events.This makes understanding the long-term pattern of those events more statistically robust. 

This step uses the Loss Curve Generator, an online interface available at https://idf-rmsg.shinyapps.io/FinancialRiskPooling.


Guidance 
""""""""""""""""""""""


1. Data Selection Tab

 In the Loss Curve Generator tool, choose Advanced or Basic Input.
 Choose country from the drop-down list

 .. figure:: ../src_img/screenshots/step2_1_input.png
   :scale: 25%
   :alt: Data selection tab

   Data selection tab


 In advanced mode, upload your CSV of historical events (completed in step 1).
 A graph of uploaded data appears at the bottom for validation.

 Set the cost per person you wish to set (this can be identified using losses divided by the number of people affected  and averaged - or there may be an established cost per person you may be using or already established for the country  and risk).
 Select the data type and the metrics which you would like displayed on the graphs.
 A graph of data appears at the bottom for validation.

 .. figure:: ../src_img/screenshots/step2_2_manual_input.png
   :scale: 25%
   :alt: Advanced .csv file upload

   Advanced .csv file upload


2. Scaling

 Choose from the drop down menu of the scaling and trending data you want to include in your data set - Population, inflations, GDP or no scaling.


 .. figure:: ../src_img/screenshots/step2_3_scaling.png
   :scale: 25%
   :alt: Scaling options

   Scaling options


 The graph now shows the de-trended results.


3. Simulation

 Click Run Tool (This could take up to 5 minutes).

 .. figure:: ../src_img/screenshots/step2_4_run.png
   :scale: 25%
   :alt: Run tool - click button

   Run tool - click button


 The tool tries multiple distributions, each with 15,000 simulated events and selects the best possible fit to the data.These include, Log Normal, Poisson, Pareto (curve shapes).
 You can change the distribution selection - but it is advised to only do this with technical expert support. 

 The graph can display for each risk a display of the fitted distribution based on the observed data that was inputted, the simulated events through the model and both combined.


 .. figure:: ../src_img/screenshots/step2_5_simulations.png
   :scale: 25%
   :alt: Simulation options

   Simulation options

   
4. Outputs

 Select each risk to see the simulated losses.
 Toggle 95% confidence intervals to see the range of uncertainty at each return period.
 The tool also provides graphs and other exhibits (e.g., estimated annual losses, loss exceedance curves, tables of return periods, comparisons of distributions).
 You can input a budget value to generate the graph 4 exhibit to identify the annual funding gap. 

 .. figure:: ../src_img/screenshots/step2_7_outputs.png
   :scale: 25%
   :alt: Simulation outputs

   Simulation outputs


 Download Simulations to save your new synthetic event catalog (it will download in the format needed for input into the Risk Pool Structuring spreadsheet tool).

 .. figure:: ../src_img/screenshots/step2_8_downloadsims.png
   :scale: 25%
   :alt: Download simulation outputs using the buttons
     
   Download simulation outputs using the buttons


 Now you have a robust database of observed and simulated crisis events and their losses, from which the patterns of magnitude and severity can be better understood. This gives a much stronger view of the statistical relationships.



Key Decision-Making Considerations
""""""""""""""""""""""""""""""""""""""""

**How many simulated events are enough?**
How many simulations you include will depend on the computing power you have and also the number of events you are basing that simulation on. If like in the example, you only have 3 events with data. Running 20,000 events is likely going to be highly uncertain, so perhaps less is more in that case. A statistician or actuary would help you make a sensible choice.

**What data trending do we include?**
Here, it will consider what other changes happened alongside this data, which might influence the data and the objectivity of that pattern you are trying to understand. This can include population changes, price and cost changes with inflation. Once those trends are identified, the data related to them can be included to have those associated patterns in the data removed. 

**What statistical distributions will be used to generate the synthetic catalogue?**
There are many different shapes of curves that can be plotted through the graph of the catalogue to try and discern most accurately the related pattern of magnitude and frequency of that risk. A statistician will look at different options to fit a curve. Usually, there will be no one perfect obvious pattern, so there will be trade-offs on which distribution is selected. Understanding the implications of those trade-offs in that decision would need to be understood by decision-makers where there may be over or under-estimates at different parts of the risk relationship.

**What level of statistical uncertainty do we have?**
How well the selected distribution fits the data will generate uncertainty, where the best fit is made. Statisticians will look to minimise the uncertainty as much as possible, but as with all things, this can only be minimised. Decision-makers will need to know, understand, and accept this. 

**How reliable is our understanding of the magnitude frequency patterns?**
Reviewing the quality of the event data available and the robustness of the distribution fitting will give decision-makers a clear idea of how reliable our knowledge of the magnitude frequency relationship is. This is important as the weight of the risk in the pool may be under or overestimated due to this. When it comes later on to assigning financial coverage to those risks, this would need to be a consideration alongside the nature of the risk depicted in the distribution. 

You can use the Financial to statistically simulate additional events, improving your understanding of how frequently certain severity levels might occur.


There are two kinds of catalogs that can be inputted. These include historical catalogs, where the base data you are inputting has come from recorded historical events. The second are catalogs which have already been generated by a model. In this case you may be using the tool to align to the 15 thousand years of events that this tool provides, to check the curve fitting or to convert the output into the format needed for the Risk Pool Structuring tool.

The Loss Curve Generator allows you to only run one type of input at a time. For example you can not combine historical events _and_ modelled events for Earthquake in Chile. 
You also cannot add both a modelled simulated catalog and an historic simulated catalog for the same country peril in the Risk Pool Structuring tool. Currently it is either or for each country's risk. However, if different risks and countries you can use a mixture in the Risk Pool Structuring Tool (i.e modelled simulation for drought in Mali and simulation based on historical data for flood in Colombia).



.. admonition:: Fundamental Principal

   The more event data you have from historical catalogs, the stronger the stochastic modelling will be to create a robust view of the risk and the shape of the magnitude and frequency relationship.

   If only a small number of historical event information data points are available, it will create significant uncertainty in your financial risk modelling. This uncertainty increases if events close to your later attachment/trigger points are not represented. Caution must be exercised in these cases as it may not be sensible to allow such low data risks to be included in the pool, as they may not capture funding liabilities that could be included. 








Step 3: Add Your Synthetic Data to the Risk Pool Structuring tool
-----------------------------------------------------------------------

Once the data set has been generated, it can be added to the Risk Pool Structuring tool to begin to examine the different financial options in the global risk pool and what predictable funding this could provide for the different risks. 


The Risk Pool Structuring tool can be accessed on the `Financial Risk Pooling Github <https://github.com/IDF-RMSG/FinancialRiskPooling/blob/develop/DisasterRiskPoolingTool/RiskPoolingTool_main_v20250306.xlsb>`_, or `downloaded directly <https://github.com/IDF-RMSG/FinancialRiskPooling/raw/refs/heads/develop/DisasterRiskPoolingTool/RiskPoolingTool_main_v20250306.xlsb>`_.


Example data can be used to try the tool: `here on the Financial Pooling Tool GitHub <https://github.com/IDF-RMSG/FinancialRiskPooling/blob/develop/DisasterRiskPoolingTool/PoolingTool_UploadExample.xlsx>`_ (or `download directly <https://github.com/IDF-RMSG/FinancialRiskPooling/raw/refs/heads/develop/DisasterRiskPoolingTool/PoolingTool_UploadExample.xlsx>`_).




Tool Guidance 
""""""""""""""""""""""

1. Open the Risk Pool Structuring tool and select “Country 1 Data Input.”

 .. figure:: ../src_img/screenshots/step3_dataInput.png
   :scale: 25%
   :alt: Country data input - repeat for all countries you are including in the pool

   Country data input - repeat for all countries you are including in the pool

   
2. Paste in the columns from your downloaded synthetic CSV for your first country event and simulated data set with the headers: Simulation, Type, Event ID, Region, Peril, and Financial Loss (USD)

3. Check for Errors: Column G indicates True/False if any mismatch or missing data is found. Table A5 to D9 checks True/False errors on the peril information and type. Correct any issues, then re-upload if necessary.

4. After successful upload, the Risk Pool Structuring tool automatically generates various loss scenarios using the new data.
   

Repeat this step for all of your country data sheets to upload them to the subsequent Country data input tabs. Remember you can only add in one catalog per country risk. You cannot add in both a modelled and historic based catalogue for the same country risk.  


The tool has now been primed with the knowledge of the shape and nature of the risks that will be within our risk pool. You’re now ready to move on to Phase 2: Setting up financing triggers and thresholds against these risk estimates.

 
  
