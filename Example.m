%% Define Imaging Parameters
TransPara.Pitch=0.1e-3;
TransPara.CenterFrequency=15.625e6;
BeamformPara.AxialInterp=2;
BeamformPara.SoS=1481;
BeamformPara.SamplingFreq=62.5e6;
BeamformPara.FNum=1;
BeamformPara.DCOffset=0.1;
BeamformPara.Angles=linspace(-4,4,9);
BeamformPara.InitDepth=0;
BeamformPara.DecimFactor=4;
BeamformPara.CarrierFreq=15.625e6;
BeamformPara.LPFOrder=60;
BeamformPara.FractionalBandwidth=0.6;
SVDPara.InitCutOff=10;
SVDPara.EndCutOff=50;
%%
% ---USER SHOULD LOAD RF DATA HERE---
% ---Example RF data could be downloaded from the UoFI Box---
% ---Example RF data is a 400 Frames Microbubble Trace Data acquired with
% ---L22-14vX---
%% NSI Process and Display
SizeRF=size(RF);
DelayProfile=DelayGen(TransPara,BeamformPara,SizeRF);
ApodProfile=ApodGen(TransPara,BeamformPara,SizeRF);
IQ=NSIBeamformer(BeamformPara,DelayProfile,ApodProfile,RF);
[NSI,DAS]=SVDFilt(SVDPara,IQ);
ImgDisp(NSI,DAS,70);
