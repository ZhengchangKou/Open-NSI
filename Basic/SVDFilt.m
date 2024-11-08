function [NSI,DAS]=SVDFilt(SVDPara,IQ)
    %DAS SVD FILTER
    [Depth,EleCount,ApodCount,FrameCount]=size(IQ);
    CasoratiDAS=reshape(squeeze(IQ(:,:,4,:)),[Depth*EleCount FrameCount]);
    [D,S,V]=svd(CasoratiDAS,'econ');
    for k=1:SVDPara.InitCutOff
        S(k,k)=0;
    end
    for k=FrameCount-SVDPara.EndCutOff:FrameCount
        S(k,k)=0;
    end
    CasoratiDAS=D*S*V';
    DAS=reshape(CasoratiDAS,[Depth EleCount FrameCount]);
    %NSI SVD FILTER
    CasoratiNSI=reshape(squeeze(IQ(:,:,1:3,:)),[Depth*EleCount*3 FrameCount]);
    [D,S,V]=svd(CasoratiNSI,'econ');
    for k=1:SVDPara.InitCutOff
        S(k,k)=0;
    end
    for k=FrameCount-SVDPara.EndCutOff:FrameCount
        S(k,k)=0;
    end
    CasoratiNSI=D*S*V';
    NSI=reshape(CasoratiNSI,[Depth EleCount 3 FrameCount]);
end