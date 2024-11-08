function DelayProfile=DelayGen(TransPara,BeamformPara,SizeRF)
    Depth=SizeRF(1);
    EleCount=SizeRF(2);
    AngleCount=SizeRF(3);
    [X,Z] = meshgrid((0:EleCount-1),(0:((Depth-1)*BeamformPara.AxialInterp)));
    dZ = BeamformPara.SoS/BeamformPara.SamplingFreq/BeamformPara.AxialInterp/2;
    Zd = Z*dZ+BeamformPara.InitDepth/TransPara.CenterFrequency*BeamformPara.SoS;
    Xd = X*TransPara.Pitch;
    delays = zeros((Depth-1)*BeamformPara.AxialInterp+1,EleCount,EleCount,AngleCount);
    for CurrAngle=1:AngleCount
        theta=BeamformPara.Angles(CurrAngle);
        for k = 1:EleCount
            if theta >= 0
                delays(:,:,k,CurrAngle) = round(((Zd)*cosd(theta) + (k-1)*TransPara.Pitch*sind(theta)...
                    + sqrt((Zd).^2 + ((k-1)*TransPara.Pitch-Xd).^2)-BeamformPara.InitDepth/TransPara.CenterFrequency*BeamformPara.SoS*2)/ BeamformPara.SoS*BeamformPara.SamplingFreq*BeamformPara.AxialInterp)+1;
            else
                delays(:,:,k,CurrAngle) = round(((Zd)*cosd(theta)+((EleCount-1)*TransPara.Pitch-(k-1)*TransPara.Pitch)...
                    *sind(abs(theta)) + sqrt((Zd).^2 +...
                    ((k-1)*TransPara.Pitch-Xd).^2)-BeamformPara.InitDepth/TransPara.CenterFrequency*BeamformPara.SoS*2)/ BeamformPara.SoS*BeamformPara.SamplingFreq*BeamformPara.AxialInterp)+1;
            end
        end
    end
    delaylim=min(max(delays,1),(Depth-1)*BeamformPara.AxialInterp+1);
    clear delays
    x=1:EleCount;
    z=1:((Depth-1)*BeamformPara.AxialInterp+1);
    [X,Y,Z]=meshgrid(x,z,x);
    clear Y
    DelayProfile = zeros((Depth-1)*BeamformPara.AxialInterp+1,EleCount,EleCount,AngleCount);
    for CurrAngle=1:AngleCount
        DelayProfile(:,:,:,CurrAngle)=sub2ind([(Depth-1)*BeamformPara.AxialInterp+1 EleCount EleCount],delaylim(:,:,:,CurrAngle),X,Z);
    end
end