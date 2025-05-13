.. _phase2_reference-label:

Phase 2: Setting your financial structure
==========================================================

From this phase, the Risk Pool Structuring tool is used.
It enables you to include up to five countries and four hazards (cyclone, flood, drought and earthquake). 

The Risk Pool Structuring tool can be downloaded `here on the Financial Risk Pooling Tool GitHub <https://github.com/IDF-RMSG/FinancialRiskPooling/blob/develop/DisasterRiskPoolingTool/RiskPoolingTool_main_v20250306.xlsb>`_ (or `download directly <https://github.com/IDF-RMSG/FinancialRiskPooling/raw/refs/heads/develop/DisasterRiskPoolingTool/RiskPoolingTool_main_v20250306.xlsb>`_).


.. figure:: ../src_img/guidanceimg/phase2.jpg
  :scale: 25%
  :alt: Phase 2 steps 


Step 4: Select the Countries and Risks to Include
----------------------------------------------------

Before we begin to add risks to our pool and add funding coverage against them. There are a number of decisions or areas of understanding and prioritisation that would have to be established outside of the tool and the calculation. 



Guidance
"""""""""""""""""

1. In the Risk Pool Structuring tool go to “Financial Structure Input” Tab

.. figure:: ../src_img/screenshots/step4_structure.png
  :scale: 25%
  :alt: Financial Structure Input

  Financial Structure Input


2. Choose the countries to be included in your risk pool in the table in cells B6 to B10

3. In the table in cells E6 to F15 you will now have those countries available in the drop down menu in column E. You can then go on to select the hazards (perils) from your catalogue that you want to cover in that country.

These will now show up in the structuring table in cells in A and B 23.



Key Decision-Making Considerations
""""""""""""""""""""""""""""""""""""""""

**Who has requested coverage and how much?** Firstly, you are likely to have some sort of mechanism where those who would be utilising the pre - positioned disaster funding could request coverage support. Certain conditions may be in place for prepositioned funding coverage. These may be how effective and well-planned the delivery of support with the released funding is or potentially what existing financial coverage and support is already in place. How you consider those requests will depend on your own governance and requirements. But clarity on that for transparency should be established.

**What type of coverage have they requested?** How much has been requested for different levels of risk would also need to be considered in the financial structure. There may be preferences for more funding for different severity events, depending on the financial needs and gaps.

**What other funding coverage is in place for those risks?** Providing funding coverage from your pool for the entirety of the possible funding risk is unlikely. Often, a mixture of funding lines come in for different emergencies and at different severities. So, understanding the landscape in which your prepositioned funding in the pool sits will be important before constructing the financial structuring. This will ensure the most efficient arrangement of funding for future crises is used. Having the financing for a crisis well strategically structured and arranged also means that the corresponding emergency planning and operations will be incentivised to do the same. Chaotic financing systems often intersect in creating chaotic operational systems in disasters. 




Step 5: Set the Coverage Layers
----------------------------------


.. figure:: ../src_img/screenshots/step5_coverageLayers.png
  :scale: 25%
  :alt: Setting coverage layers

  Setting coverage layers


Guidance
"""""""""""""""""

1. Define the financing lines

The Risk Pool Structuring tool offers the opportunity to consider layering funding for the risk. This means identifying two financing lines for different severity events or types of actions:

 * Layer 1 is funding that is perhaps covered by national or local funding lines or other risk financing mechanisms. It could also be called a deductible or excess in some cases. It's any funding to cover the risk not coming from your pool.  Layer 1: Local/national coverage or a “deductible.” Input values into - Cells E24-L33.

 * Layer 2 is what you want to be included in your global risk pool for financial coverage. Input values into Cells M24-T33.


The remaining parameters apply to both layer 1 and Layer 2.


2. Define Average cost of payout per person** 

In cells D24-33 select the average cost per person you are considering in your payouts. This may be specific to each country and risk. There are a few ways you might arrive at this value:

 * Using the historical loss data and the numbers of people impacted you could take a simple average cost per person. The drawback with this is that the cost of a crisis is likely to be only what was available to be spent, not necessarily what was needed. Often used by the Insurance Industry and development banks (note this may also be a limitation of the input data).

 * Use proxy metrics such as social protection payment methods or cost of the diet amounts.  The country may have an established budget per person or household method for different kinds of crisis. Often used in micro- and meso-level insurance schemes. 

 * Create the cost per person using planning and delivery scenarios - using the loss catalogues to set quantitative scenarios, emergency plans and delivery needs and volumes for the cohorts of people at risk could be costed and a per person average budget obtained. :ref:`The Start Ready approach<ExtGuidance_reference-label>`) is useful for sovereign risk financing and disaster operations planning.  


3. Controlling the taps

If you imagine, our layers are big tanks of water with many pipes and taps running off them. To make sure we don’t drain the tank and not have available water/funds for when we really need it, we have to put some limits on the use of the taps and how and when they can draw water from the tank. This is how we set the financing structure. 

 3.1. People Impacted at Attachment - Attachment Point (“trigger”) (cells E24-33):
  
   * The severity (e.g., 1-in-5-year event which is the same as an event with a 20% probability of occurring in any given year) at which a specific number of people are at risk and the funding layer begins paying out (when we can turn that tap on). This could also be called a trigger point or threshold. It is depicted by severity in the form of a return period value, with an associated number of people and financial requirement.

   * Using the cost per person and the number of people the tool automatically generates the return period event level and financial level this relates to. This is automatically generated in column I and xxx


 3.2. The number of people covered (Cells F24 - 33): Here you can input the number of people at risk you would want to be covered by the funding. This will automatically generate the top of your coverage for that layer in column J - Equivalent monetary cost at Exhaustion.


 3.3. Exhaustion Point (“cap”) (automatically generated): The point at which this layer stops paying (when the tap needs to be turned off), where another layer or additional coverage might start. This could also be referred to as a cap or a limit on when that layer of funding will be exhausted. For example, perhaps you have a national fund that covers your layer 1, but you know you will never have more than 1 million dollars to payout from that fund for that risk; this is when it exhausts. 

 
 3.4. Percentage ceded to the layer: Each layer of risk will hold a total financial value, numbers of people at risk and equivalent monetary values, for the totality of the risk in that layer. This related to the severity RP of that scenario of disaster. But the whole of the risk may not be all of your burden to cover. It is likely that each of those layers of risk will have multiple actors and financing lines responding in such scenarios. In this case you may not need to have financial coverage for the whole layer. If this is the case you would need to identify the % of that layer you are covering in layer 1 and 2. This is another lever in which to increase or decrease your financial liability. You could think of it as how wide your tap is.


 3.5. Reinstatement count: How many times the full coverage can trigger in a year (how often we can turn the tap on and off in one year for a stated amount of water to flow) assuming full replenishment of funds each time. This refers to the number of times in a year the attachment or trigger will reset and allow for another payout. For example, you may allow for three full disbursement flood triggers in one year but no more after that. You have to limit how many times the tap can be used; otherwise, you may drain all the tanks at one time. 


 3.6. Aggregate Limit: This is the total potential amount of funding accounting for attachments, exhaustion and reinstatements that the layer could be liable for in any one year.  So, the total potential amount of water in the tank that would need to be available in the very worst case for that tap/risk (assuming the water gets replenished as per the reinstatement count). 


**Repeat this parameterisation for Layer 2.**

.. figure:: ../src_img/screenshots/step5_coverageLayers2.png
  :scale: 25%
  :alt: Setting coverage layers - layer 2

  Setting coverage layers - layer 2



.. admonition:: Fundamental Principal
   
   The magnitude frequency relationship can sometimes be displayed as a return period, also known as a recurrence interval or repeat interval. It is the average time or an estimated average time between events of the same magnitude. Impact metrics such as people at risk,  losses, costs or alike linked to the hazard magnitude can also be displayed as return periods of those occurrences. 



When an event occurs or is forecasted to in some cases, all of the funding of that magnitude and below gets activated to begin flowing from the taps. When the prepositioned funding runs out in layer 1 through the taps, and we enter the layer two magnitude zone, then layer 2 taps start working up until the triggered level, and so on and so on.

The clever bit with risk sharing in a pool is that you are able to combine many different risks and multiply the probabilities of occurrence. Different country risks can be held together and the funding flow between in our global risk pool.


.. admonition:: Fundamental Principal
   
   When you combine and multiply probabilities, the overall probability goes down - this is what risk pooling takes advantage of - sharing risk. 

   This means we can be much more efficient and not allow money to sit around waiting for a trigger, or one that very rarely happens but still allows funding guarantees to be met, when the event occurs and hits attachment point. This kind of mechanism is also sometimes called a co-operative model. We will get to this more on the pool analysis tab. 


.. figure:: ../src_img/guidanceimg/globalRiskPool.png
  :scale: 25%
  :alt: Schematic of a risk pool
  
  Schematic of a risk pool


4. When all steps are complete, make sure all of the data checks are green and click Run Modelling to generate coverage results.

.. figure:: ../src_img/screenshots/step5_Run.png
  :scale: 25%
  :alt: Run model

  Run model

