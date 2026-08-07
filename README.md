# Team 4's Solution to the Drone Payload Capacity and Structural Design Analysis Problem
This project challenges a team into applying core concepts of physics and engineering to the real-world problem of maximizing the payload capacity of a quadcopter. At the end of this project the team will have practiced designing drone arms and 3D modeling them, programing with MATLAB, and propose a final drone arm design through quantitative and cost analysis.  
  
Please refer to 'DroneDesign_StudentProjectTemplate_Preview.pdf' located in the Documentations folder and [Link](https://github.com/mathworks/MATLAB-Simulink-Challenge-Project-Hub/tree/main/Classroom%20Challenge%20Projects/Projects/Drone%20Payload%20Capacity%20and%20Structural%20Design%20Analysis) for more specifics about assumptions and requirements.

# Objective
Design at least 2 drone arms that can carry a 0.5 Kg payload at minimum, has a 2:1 thrust-to-weight ratio (TWR), a factor safety of at least 1.5. After doing so, produce a final report from the results that were gathered for the drone arms and give a final design recommendation with justification from analysis of results. 


# Project Details
Our team approached this project as a learning opportunity to better our skills with the suggested. So, each team member proposed and designed at least one drone arm. As a result of this we ended up with 4 comparable drone arms. Being the Triangle Arm, Circle Arm, Beam Arm, and Lattice Arm designed by each member. Afterwards we coded a MATLAB program using their built in Partial Differential Equation Toolbox. Allowing us to gather the results necessary to fulfill the project.

| Triangle Arm | Circle Arm |
| :---: | :---: |
| <img width="644" height="553" alt="SLDWORKS_ej1l8cpXoL" src="https://github.com/user-attachments/assets/e6ee151e-3aa9-4179-9eb6-90fba3f33f28" /> | <img width="644" height="553" alt="chrome_BmiyGrPS0T" src="https://github.com/user-attachments/assets/2ee37e7d-fa14-442a-ac18-3d9ac9a0b1b4" /> |
| Beam Arm | Lattice Arm |
| <img width="644" height="553" alt="image" src="https://github.com/user-attachments/assets/6b5db0de-dcc7-4c61-82a5-771b1f55a37a" /> | <img width="644" height="553" alt="SLDWORKS_YRguiKzV26" src="https://github.com/user-attachments/assets/b860d216-5403-475a-aea0-33df35c035d4" /> |


# Project Solution Instructions
The following are steps on how to run the main program of this project being, "Full_Run_Fin.mlx".  
In the case that unexpected problems occur when following the Steps section and troubleshooting isn't fixing it. Please refer to the Backup Steps section to view the results. Otherwise Backup Steps can be skipped
## Steps:  
[Video Instructions](https://youtu.be/7ymWV30FWfM)
1. Download the repository/zip file
2. Right-click the zip and click extract all then, extract
3. A new window should open up. Click the folder in the window and double-click "Full_Run_Fin.mlx"
4. Click the run button and wait. (It takes about 4-5mins)
5. While waiting you should disable synchronous scrolling by right-clicking the right side and hitting "Disable synchronous scrolling" and scroll down to the bottom of both sides
6. After it has finished running you can view the results with the PDE results visualizer.

### Backup Steps
If you are reading this section then a problem has occurred with the "Full_Run_Fin.mlx" program. If this is not the case skip this section. Otherwise this section gives instructions on how to view the results with the data our team got from running this program.  
[Video Instructions](https://youtu.be/FH9hUVbYAe8)  
1. Download the following file (~84Mb) : [Link](https://drive.google.com/file/d/1Xmdh4RBVJ9Zax5G-46Jol3pIxfLdXrC2/view?usp=sharing)
2. Put the downloaded file into the Backup folder from the download. (or download the backup folder only and put the mat file in there).  
3. Open the backup program and run it.
4. You should now be able to view the results that our team got from running the "Full_Run_Fin.mlx" program.

# Results
Please download the repository and open the "Final Report.pdf" to view the report.

Note: The thrust to weight ratio (TWR) results are locked to 2 in order to maximize payload capacity. 
After running "Full_Run_Fin.mlx" and letting it finish. It will give the following result table:

<img width="1406" height="1085" alt="image" src="https://github.com/user-attachments/assets/9e7bf3fc-61b9-4159-a4bd-504a5ebc924b" />

# Reference
-[Introduction to Finite Element Analysis in MATLAB](https://matlabacademy.mathworks.com/details/introduction-to-finite-element-analysis-with-matlab/otmlfea)  
-[Example Finite Element Analysis Workflow](https://www.mathworks.com/help/pde/ug/deflection-analysis-of-bracket-femodel.html)  
-[Research Paper "Stress and vibration analysis of a drone"](https://iopscience.iop.org/article/10.1088/1757-899X/1009/1/012059/pdf)  
-[Real world Payload Data](https://www.jouav.com/blog/drone-payload.html)  

# Contact 
Email: rdnguyen.work@gmail.com


# Contributions
Ryan Nguyen
  -  Designed and modeled the beam drone arm
  -  Wrote "Full_Run_Fin.mlx" program
  -  Wrote "BackupProgram.mlx" program
  -  Writing report\
    -  Wrote section on beam arm and cost analysis\
    -  Formatting\
    -  Graphs and research of payloads  

Sheryl
  -  Designed and modeled circular drone arm
  -  Fine tuned FEA results\
    -  Wrote "TWR_and_MaxPayload.m" a program to gather FEA, TWR, and cost results
  -  Performed hand calculation checks for results\
    -  See "handCalculationExample.pdf" in Documentation
  -  Writing report\
    -  Wrote section on circular arm, goals and objectives, analysis, and conclusion\
    -  Provided pictures/documentation of circular arm  
  

Ezekiel Savage
  -  Designed and modeled triangle arm
  -  Fine tuned FEA results\
    -  Wrote 'checkDroneArm.m' a program to perform quick FEAs\
   -  Writing report\
     -  Wrote section on triangle arm\
     -  Provided pictures/documentation of triangular arm  
  

Peter Yang
  -  Designed and modeled lattice arm
  -  Performed hand calculation checks for results\
    -  See DorneTeam4_Hand_Calculations.pdf in Documentation folder
  -  Writing report\
    -  Wrote section on lattice arm\
    -  Provided pictures/documentation of lattice arm
  -  Wrote a program to perform FEA on Lattice Arm
    -  Go to checks > Peter's Functions
