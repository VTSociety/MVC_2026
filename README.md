# MVC_2026
Repository of the 2026 IEEE VTS Motor Vehicle Challenge (MVC) regarding the power sizing and energy management design of a refrigerated lorry.

![2025-10-14 14 31 05](https://github.com/user-attachments/assets/7166d617-7086-4b38-af79-e9b3fe04d142)


## Introduction

<img width="355" height="239" alt="IPE_Fig1_FT" src="https://github.com/user-attachments/assets/0542e3d5-03ae-4310-b58b-2b8ea5ff5397" />


The topic proposed for the IEEE VTS Motor Vehicle Challenge 2026 (MVC 2026) consists of two tasks. Firstly, the participants are required to design a powertrain for a dual-motor refrigerated lorry, which is able to transport 10 tons of frozen food. The lorry must be equipped with a refrigeration system that can maintain the temperature of the cargo at -18°C. The second task consists of developing the lorry’s energy management strategy. The motor and battery pack must be selected to maximize efficiency and reduce the time to complete the task. The battery pack can be charged in three different ways: wireless charging, plug-in charging, and regenerative braking. The MVC 2026 participants should also consider the impact of the lorry’s weight as well as road slope, traffic, and wind on its performance and energy consumption.

<img width="814" height="371" alt="IPE_SimulationScheme" src="https://github.com/user-attachments/assets/b8abe198-8ddf-4ff3-bffe-1641f4f09216" />

## Team registration
The participants willing to participate to the MVC 2026 competition must subscribe the team at this [LINK](https://forms.gle/kw6bpar6wxactC3k8). End of subscriptions is :red_circle:<mark>1st of February, 2026</mark>:red_circle:.


## Submission of proposal

The proposal(s) must be submitted by using the link (available after February 1st, 2026). The deadline for the proposal submission is :red_circle:<mark>1st of March, 2026</mark>:red_circle:.

For safety reasons, the submission can be made only by people with a Gmail account. In the form, it is possible to indicate the academic/industrial contact. If the possession of a Gmail account is an issue, please get in touch with MVC 2026 organizers.

## Rules
The participants to the challenge will operate only on the SystemDesign.m and ProposedEMS.m MATLAB scripts, as well as the EMS block provided within the simulation files. All the other scripts and simulation blocks must not be modified. <ins>The final evaluation will be carried out by implementing the EMS block developed by each participant and the specified scripts in the original simulation file</ins>. That is, <mark>all the modifications made in subsystems which are not the EMS one and the other scripts will be discarded</mark>. 

Important rules that the submitted proposal must satisfy for being considered valid in this competition
1. All parameters and data provided in the "EMS" section of the main.m script can be used to develop the strategy.
2. All parameters adopted for the developed strategy **must** be specified only in the "ProposedEMS.m" script.
3. Energy constraints of the battery must always be guaranteed.
4. The simulation must not exceed 2.5 times the duration of the defined route (composed by N laps).

## What has to be uploaded for evaluation
In order to evaluate each proposal, the teams must submit in the form (link available after February 1st, 2026) the following files:
- "ProposedEMS.m" renamed as "nameTeam_numProp_ProposedEMS.m" where "numProp" must identify the proposal number of the team. If only one proposal is presented, please use "num1" (e.g., "teamWhite_prop1_ProposedEMS.m"). Please avoid spaces in the file name.
- "SystemDesign.m" renamed as "nameTeam_numProp_SystemDesign.m" where "numProp" must identify the proposal number of the team. If only one proposal is presented, please use "num1" (e.g., "teamWhite_prop1_SystemDesign.m"). Please avoid spaces in the file name.
- "EMS_sim.slx" renamed as "nameTeam_numProp_EMS.slx" where "numProp" must identify the proposal number of the team. If only one proposal is presented, please use "num1" (e.g., "teamWhite_prop1_EMS.slx"). Please avoid spaces in the file name.
- overall simulation files of the proposed solution (used as a backup version). Create a ZIP file including the folders Parameters, Reference, Result and Scoring, and the files main.m, MVC2026_sim.slx, and EMS_sim.slx. Rename the ZIP file as “nameTeam_numProp_MVC2026.zip”. The same considerations made for the EMS Matlab script holds. Please note the ZIP folder is only a backup. Evaluation will mainly be based on the individual submitted files.
Please note that the team name must correspond to the name specified in the registration form.

## Release Notes
Please refer to the [CHANGELOG.md](https://github.com/VTSociety/MVC_2026/blob/main/CHANGELOG.md) file for modifications of the simulation and differences with respect to the paper in the [Bibliography](), that is ([preprint version here](Materials)).

Remarks:
* Please take notice of the [Discussion board](https://github.com/VTSociety/MVC_2026/discussions) for Q&A. Start a new discussion if you've found no answer to your issue. No answers will be given to questions related the MVC 2026 by private emails.

## Bibliography

## License
All files of the repository "MVC 2026" are intended solely for the aim of the Motor Vehicle Challenge competition organised within the IEEE VTS Society. The Authors declined all responsabilities for usage outside this context. 

Copyright © 2025-2026. The code is released under the [CC BY-NC 4.0 license](https://creativecommons.org/licenses/by-nc/4.0/legalcode). Link to [short summary of CC BY-NC 4.0 license](https://creativecommons.org/licenses/by-nc/4.0/). For attribution see also [license file](LICENSE.md).



