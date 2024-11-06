# Open-NSI
This GitHub Repo is used to share the Null Subtraction Imaging (NSI) 
code with Ultrasound Imaging researchers.
![image](https://github.com/user-attachments/assets/c2cae81f-9cca-41ef-ae6b-317897656255)
# Null Subtraction Imaging
NSI is a computationally inexpensive nonlinear beamforming method.
It has been used in grating lobe reduction and power Doppler Imaging.
A complete processing chain of NSI power Doppler is included in this Repo.
# Project Structure
Top Level Function (top.m)
  Delay Profile Generation (delaygen.m)
  Apodization Generation (apod.m)
  Beamforming (bf.m)
  Clutter Filter (clutterfilter.m)
  Display (nsidisp.m)
# Requirement
Matlab with GPU computing license
Nvidia GPU with VRAM > 8GB (depending on your data size)
# Academic References To Be Cited
Z. Kou, R. J. Miller and M. L. Oelze, "Grating Lobe Reduction in Plane-Wave Imaging With Angular Compounding Using Subtraction of Coherent Signals," in IEEE Transactions on Ultrasonics, Ferroelectrics, and Frequency Control, vol. 69, no. 12, pp. 3308-3316, Dec. 2022, doi: 10.1109/TUFFC.2022.3217993.
Z. Kou, M. R. Lowerison, Q. You, Y. Wang, P. Song and M. L. Oelze, "High-Resolution Power Doppler Using Null Subtraction Imaging," in IEEE Transactions on Medical Imaging, vol. 43, no. 9, pp. 3060-3071, Sept. 2024, doi: 10.1109/TMI.2024.3383768.
  
