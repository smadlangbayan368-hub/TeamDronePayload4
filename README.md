# Team 4's Solution to the Drone Payload Capacity and Structural Design Analysis Problem

This project challenges a team into applying core concepts of physics and engineering to the real-world problem of maximizing the payload capacity of a quadcopter. At the end of this project the team will have practiced designing drone arms and 3D modeling them, programing with MATLAB, and propose a final drone arm design through quantitative and cost analysis.

# Project Details
Briefly describe your team's approach to the project and how you implemented your solution.

# Project Solution Instructions
# # Steps:
  note: In case of an error please scroll down to backup steps.  
1. Open "Full_Run_Fin.mlx" in MATLAB
2. Click the run button and wait. (It takes a while to finish running)
3. While waiting you disable synchronous scrolling and scroll down to the bottom of the code
4. After it has finished running you can view the results with the PDE results visualizer.

# # # Backup Steps
If you are reading this section then a problem has occurred with the "Full_Run_Fin.mlx" program. If this is not the case skip this section. Otherwise this section gives instructions on how to view the results with the data our team got from running this program.  
1. Download the following file:
2. Put the downloaded file into the Backup folder from the download.
3. Open the backup program and run it.
4. You should now be able to view the results that our team got from running the "Full_Run_Fin.mlx" program.

# Results
After running "Full_Run_Fin.mlx" and letting it finish. It will give the following result table:
<img width="1232" height="803" alt="image" src="https://github.com/user-attachments/assets/b4b732ea-62ff-40d7-b601-7a2fb7048f9f" />



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
