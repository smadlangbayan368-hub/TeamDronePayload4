#**GO TO MAIN BRANCH**

# Team 4's Solution to the Drone Payload Capacity and Structural Design Analysis Problem
This project challenges a team into applying core concepts of physics and engineering to the real-world problem of maximizing the payload capacity of a quadcopter. At the end of this project the team will have practiced designing drone arms and 3D modeling them, programing with MATLAB, and propose a final drone arm design through quantitative and cost analysis.

# Objective
Design at least 2 drone arms that can carry a 0.5 Kg payload at minimum, has a 2:1 thrust-to-weight ratio (TWR), a factor safety of at least 1.5. After doing so, produce a final report from the results that were gathered for the drone arms and give a final design recommendation with justification from analysis of results. 


# Project Details
Our team approached this project as a learning opportunity to better our skills with the suggested. So, each team member proposed and designed at least one drone arm. As a result of this we ended up with 4 comparable drone arms. Being the Triangle Arm, Circle Arm, Beam Arm, and Lattice Arm designed by each member. Afterwards we coded a MatLab program using their built in Partial Differential Equation Toolbox. Allowing us to gather the results necessary to fulfill the project.

| Triangle Arm | Circle Arm |
| :---: | :---: |
| <img width="644" height="553" alt="SLDWORKS_ej1l8cpXoL" src="https://github.com/user-attachments/assets/e6ee151e-3aa9-4179-9eb6-90fba3f33f28" /> | <img width="644" height="553" alt="chrome_BmiyGrPS0T" src="https://github.com/user-attachments/assets/2ee37e7d-fa14-442a-ac18-3d9ac9a0b1b4" /> |
| Beam Arm | Lattice Arm |
| <img width="644" height="553" alt="image" src="https://github.com/user-attachments/assets/6b5db0de-dcc7-4c61-82a5-771b1f55a37a" /> | <img width="644" height="553" alt="SLDWORKS_YRguiKzV26" src="https://github.com/user-attachments/assets/b860d216-5403-475a-aea0-33df35c035d4" /> |


# Project Solution Instructions
The following are steps on how to run the main program of this project being, "Full_Run_Fin.mlx".  
In the case that unexpected problems occur when following the Steps section and troubleshooting isn't fixing it. Please refer to the Backup Steps section to view the results.  
Otherwise Backup Steps can be skipped
## Steps:  
1. Open "Full_Run_Fin.mlx" in MATLAB
2. Click the run button and wait. (It takes a while to finish running)
3. While waiting you disable synchronous scrolling and scroll down to the bottom of the code
4. After it has finished running you can view the results with the PDE results visualizer.

### Backup Steps
If you are reading this section then a problem has occurred with the "Full_Run_Fin.mlx" program. If this is not the case skip this section. Otherwise this section gives instructions on how to view the results with the data our team got from running this program.  
1. Download the following file:
2. Put the downloaded file into the Backup folder from the download.
3. Open the backup program and run it.
4. You should now be able to view the results that our team got from running the "Full_Run_Fin.mlx" program.

# Results
Please download the repository and open the "Final_Report.pdf" to view the report.

After running "Full_Run_Fin.mlx" and letting it finish. It will give the following result table:

<img width="1406" height="1085" alt="image" src="https://github.com/user-attachments/assets/9e7bf3fc-61b9-4159-a4bd-504a5ebc924b" />

# Reference
-[Introduction to Finite Element Analysis in MATLAB](https://matlabacademy.mathworks.com/details/introduction-to-finite-element-analysis-with-matlab/otmlfea)  
-[Example Finite Element Analysis Workflow](https://www.mathworks.com/help/pde/ug/deflection-analysis-of-bracket-femodel.html)
-


# Contact 
Email: rdnguyen.work@gmail.com


# Contributions
(WIP)

Designers: Ryan Nguyen, Ezekiel Savage, Sheryl\
Coders: Ryan Nguyen, Ezekiel Savage\
Hand calculations: Sheryl, Peter Yang

Ryan Nguyen\
  -Designed and modeled beam drone arm\
  -Made the "Full_Run_Fin.mlx" program

Sheryl\
  -Designed and modeled circular drone arm\
  -Fine tuned FEA results\
  -Performed hand calculation checks for results
  

Ezekiel Savage\
  -Designed and modeled lattice type drone arm\
  -Fine tuned FEA results\
    -Created a function to perform fast FEAs, 'checkDroneArm.m'
  

Peter Yang\
  -Designed and modeled lattice drone arm\
  -Performed hand calculation checks for results\
  -Created program for weight check of drone arms
