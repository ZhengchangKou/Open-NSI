function ApodProfile=ApodGen(TransPara,BeamformPara,SizeRF)
    Depth=SizeRF(1);
    EleCount=SizeRF(2);
    ApodProfile = ones((Depth-1)*BeamformPara.AxialInterp+1,EleCount,EleCount,4);
    [X,Z] = meshgrid((0:EleCount-1),(0:((Depth-1)*BeamformPara.AxialInterp)));
    dZ = BeamformPara.SoS/BeamformPara.SamplingFreq/BeamformPara.AxialInterp/2;
    Zd = Z*dZ+BeamformPara.InitDepth/TransPara.CenterFrequency*BeamformPara.SoS;
    for k = 1:EleCount
        curpos=(k-1)*TransPara.Pitch;
        aprlimit=floor(min(curpos,(EleCount-1)*TransPara.Pitch-curpos)/TransPara.Pitch)*2;
        aprsize=min(max(round(round(Zd./BeamformPara.FNum./TransPara.Pitch)/2)*2,2),aprlimit);
        aprlim=ones((Depth-1)*BeamformPara.AxialInterp+1,EleCount);
        dclwin=zeros((Depth-1)*BeamformPara.AxialInterp+1,EleCount);
        dcrwin=zeros((Depth-1)*BeamformPara.AxialInterp+1,EleCount);
        zmlwin=zeros((Depth-1)*BeamformPara.AxialInterp+1,EleCount);
        aprlim(abs(X-(k-1))>aprsize./2)=0;
        dclwin((k-1)<=X)=BeamformPara.DCOffset-1;
        dclwin((k-1)>X)=BeamformPara.DCOffset+1;
        dcrwin((k-1)<=X)=BeamformPara.DCOffset+1;
        dcrwin((k-1)>X)=BeamformPara.DCOffset-1;
        zmlwin((k-1)<=X)=-1;
        zmlwin((k-1)>X)=1;
        ApodProfile(:,:,k,1)=aprlim.*dclwin;
        ApodProfile(:,:,k,2)=aprlim.*dcrwin;
        ApodProfile(:,:,k,3)=aprlim.*zmlwin;
        ApodProfile(:,:,k,4)=aprlim;
    end
end