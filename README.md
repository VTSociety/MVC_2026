# MVC_2026
Repository of the 2026 IEEE VTS Motor Vehicle Challenge (MVC) regarding the power sizing and energy management design of a refrigerated lorry.

## Introduction


## Submission of proposal

The proposal(s) must be submitted by using the above link (available after February 1st, 2026). The deadline for the proposal submission is :red_circle:<mark>1st of March, 2025</mark>:red_circle: .

For safety reasons, the submission can be made only by people with a Gmail account. In the form, it is possible to indicate the academic/industrial contact. If the possession of a Gmail account is an issue, please get in touch with MVC 2026 organizers.

## Rules
The participants to the challenge will operate only in the EMS block provided within the simulation file. All the remaining blocks must not be modified. <ins>The final evaluation will be carried out by implementing the EMS block developed by each participant in the original simulation file</ins>. That is, <mark>all the modifications made in subsystems which are not the EMS one will be discarded</mark>. 

Important rules that the submitted proposal must satisfy for being considered valid in this competition
1. All parameters defined in the "Parameters" folder can be used to develop the strategy.
2. All parameter defined in the "Reference" folder and "main_runSimulation.m" **cannot** be used to develop the strategy: the EMS **must not** adopt whatsoever a priori knowledge of the reference working cycle.
3. All parameters adopted for the developed strategy **must** be specified only in the "ProposedEMS.m" script.
4. Energy constraints of the BP and SM must always be guaranteed.

## What has to be uploaded for evaluation
In order to evaluate each proposal, the teams must submit in the form (link available after February 1st, 2026) the following files:
- "proposedEMS.m" renamed as "nameTeam_numProp_EMS.m" where "numProp" must identify the proposal number of the team. If only one proposal is presented, please use "num1" (e.g., "teamWhite_prop1_EMS.m"). Please avoid spaces in the file name.
- simulink subsystem of the proposed EMS. Rename the file as “nameTeam_numProp_Simulink.slx”. The same considerations made for the EMS Matlab script holds. Please note that **only** the Simulink block of the EMS is necessary, not the whole simulation. It is mandatory to adopt the same names of the signal in the Simulink buses.

## Release Notes
Please refer to the [CHANGELOG.md](https://github.com/VTSociety/MVC_2026/blob/main/CHANGELOG.md) file for modifications of the simulation and differences with respect to the paper in the [Bibliography](), that is ([preprint version here](Materials)).

Remarks:
* Please take notice of the [Discussion board](https://github.com/VTSociety/MVC_2026/discussions) for Q&A. Start a new discussion if you've found no answer to your issue. No answers will be given to questions related the MVC 2025 by private emails.

## Bibliography

## License
All files of the repository "MVC 2026" are intended solely for the aim of the Motor Vehicle Challenge competition organised within the IEEE VTS Society. The Authors declined all responsabilities for usage outside this context. 

Copyright © 2025-2026. The code is released under the [CC BY-NC 4.0 license](https://creativecommons.org/licenses/by-nc/4.0/legalcode). Link to [short summary of CC BY-NC 4.0 license](https://creativecommons.org/licenses/by-nc/4.0/). For attribution see also [license file](LICENSE.md).



