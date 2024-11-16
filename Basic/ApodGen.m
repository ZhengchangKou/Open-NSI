function ApodProfile=ApodGen(TransPara,BeamformPara,SizeRF)
    Depth=SizeRF(1);
    EleCount=SizeRF(2);
    ApodProfile = zeros((Depth-1)*BeamformPara.AxialInterp+1,EleCount,EleCount,4);
    [X,Z] = meshgrid((0:EleCount-1),(0:((Depth-1)*BeamformPara.AxialInterp)));
    dZ = BeamformPara.SoS/BeamformPara.SamplingFreq/BeamformPara.AxialInterp/2;
    Zd = Z*dZ+BeamformPara.InitDepth/TransPara.CenterFrequency*BeamformPara.SoS;
    for k = 1:EleCount
        aprlimit=min(k-1,EleCount-k)*2;
        aprsize=min(max(round(round(Zd(:,1)./BeamformPara.FNum./TransPara.Pitch)/2)*2,2),aprlimit);
        for q=1:(Depth-1)*BeamformPara.AxialInterp+1
            dasapod=ones(1,aprsize(q));
            zmlapod=[-ones(1,aprsize(q)/2),ones(1,aprsize(q)/2)];
            dclapod=zmlapod+BeamformPara.DCOffset;
            dcrapod=flip(dclapod,2);
            if(k<EleCount/2+1)
                ApodProfile(q,(k-aprsize(q)/2):(k+aprsize(q)/2-1),k,1)=dclapod;
                ApodProfile(q,(k-aprsize(q)/2):(k+aprsize(q)/2-1),k,2)=dcrapod;
                ApodProfile(q,(k-aprsize(q)/2):(k+aprsize(q)/2-1),k,3)=zmlapod;
                ApodProfile(q,(k-aprsize(q)/2):(k+aprsize(q)/2-1),k,4)=dasapod;
            else
                ApodProfile(q,(k-aprsize(q)/2+1):(k+aprsize(q)/2),k,1)=dclapod;
                ApodProfile(q,(k-aprsize(q)/2+1):(k+aprsize(q)/2),k,2)=dcrapod;
                ApodProfile(q,(k-aprsize(q)/2+1):(k+aprsize(q)/2),k,3)=zmlapod;
                ApodProfile(q,(k-aprsize(q)/2+1):(k+aprsize(q)/2),k,4)=dasapod;
            end
        end
    end
end
