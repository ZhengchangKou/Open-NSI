function IQ=NSIBeamformer(BeamformPara,DelayProfile,ApodProfile,RF)
    RF=single(RF);
    [Depth,EleCount,AngleCount,FrameCount]=size(RF);
    IQ=zeros(round(((Depth-1)*BeamformPara.AxialInterp+1)/BeamformPara.AxialInterp/BeamformPara.DecimFactor),EleCount,4,FrameCount,'single');
    CarrierTimeSeries = (1:((Depth-1)*BeamformPara.AxialInterp+1))/BeamformPara.SamplingFreq/BeamformPara.AxialInterp;
    ComplexCarrier = repmat(single(exp(-1i * 2 * pi * BeamformPara.CarrierFreq * CarrierTimeSeries)'),[1, EleCount, 4]);
    LowPassFilt = designfilt('lowpassfir','FilterOrder', BeamformPara.LPFOrder,...
                 'PassbandFrequency',BeamformPara.CarrierFreq*BeamformPara.FractionalBandwidth/2, ...
                 'StopbandFrequency', BeamformPara.CarrierFreq*0.5,'SampleRate',BeamformPara.SamplingFreq*BeamformPara.AxialInterp);
    BeamformedRF=zeros((Depth-1)*BeamformPara.AxialInterp+1,EleCount,4,'single');
    x=single(1:EleCount);
    z=single(1:Depth);
    [X,Z]=meshgrid(x,z);
    xq=single(1:EleCount);
    zq=single(1:1/BeamformPara.AxialInterp:Depth);
    [XQ,ZQ]=meshgrid(xq,zq);
    for CurrFrame=1:FrameCount
        for CurrAngle=1:AngleCount
            dataup=interp2(X,Z,RF(:,:,CurrAngle,CurrFrame),XQ,ZQ,'cubic');
            datamat = repmat(dataup,1,1,EleCount);
            bftemp=repmat(datamat(DelayProfile(:,:,:,CurrAngle)),1,1,1,4);
            if CurrAngle==1
                BeamformedRF=squeeze(sum(bftemp.*ApodProfile,2));
            else
                BeamformedRF=BeamformedRF+squeeze(sum(bftemp.*ApodProfile,2));
            end
        end
        FilteredIQ=filter(LowPassFilt,BeamformedRF.*ComplexCarrier);
        IQ(:,:,:,CurrFrame)=FilteredIQ(1:BeamformPara.AxialInterp*BeamformPara.DecimFactor:end,:,:);
        msg=['Curr Frame ',num2str(CurrFrame)];
        clc;disp(msg);
    end
end