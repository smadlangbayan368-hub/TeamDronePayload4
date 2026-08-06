# Team 4's Solution to the Drone Payload Capacity and Structural Design Analysis Problem

This project challenges a team into applying core concepts of physics and engineering to the real-world problem of maximizing the payload capacity of a quadcopter. At the end of this project the team will have practiced designing drone arms and 3D modeling them, programing with MATLAB, and propose a final drone arm design through quantitative and cost analysis.

# Project Details
Our team approached this project as a learning opportunity to better our skills with the suggested. So, each team member proposed and designed at least one drone arm. As a result of this we ended up with 4 comparable drone arms. Being the Triangle Arm, Circle Arm, Beam Arm, and Lattice Arm designed by each member. Afterwards we coded a MatLab program using their built in Partial Differential Equation Toolbox. Allowing us to gather the results necessary to fulfill the project.

| Triangle Arm  | Circle Arm |
| --------------- || ------------ |
| <img alt="image" src="https://github.com/user-attachments/assets/8af5bb82-9b70-4013-b9d4-30a2bd8f94ce" /> | <img width="644" height="553" alt="image" src="https://github.com/user-attachments/assets/42904b31-c0d9-4db9-8bdf-7cd5201d1a37" /> |
| Beam Arm  | Lattice Arm |
| <img width="1821" height="736" alt="image" src="https://github.com/user-attachments/assets/de3d7c23-5b73-475b-ae90-aa5c966e81e5" /> | <img width="1026" height="1025" alt="image" src="https://github.com/user-attachments/assets/8c0b5b57-ee52-4497-a420-c4e5ec57c353" /> |

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
After running "Full_Run_Fin.mlx" and letting it finish. It will give the following result table:

<img width="1276" height="1102" alt="image" src="https://github.com/user-attachments/assets/73f9cd74-e187-4091-afd7-97d1373d223b" />



# Reference
-[Introduction to Finite Element Analysis in MATLAB](https://matlabacademy.mathworks.com/details/introduction-to-finite-element-analysis-with-matlab/otmlfea)  
-[Example Finite Element Analysis Workflow](https://www.mathworks.com/help/pde/ug/deflection-analysis-of-bracket-femodel.html)
-


# Contact (optional)
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
    -Created a program for fast FEAs, 'checkDroneArm.m'
  

Peter Yang\
  -Designed and modeled lattice drone arm\
  -Performed hand calculation checks for results\
  -Created program for weight check of drone arms
