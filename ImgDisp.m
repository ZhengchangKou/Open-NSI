function ImgDisp(NSI,DAS,DR)
DASLog=20*log10(mean(DAS.*conj(DAS),3));
% DASLog=20*log10(abs(DAS));
DASNorm=DASLog-max(DASLog,[],'all');
NSILog=20*log10(mean(squeeze(abs(abs(NSI(:,:,1,:))+abs(NSI(:,:,2,:))-2*abs(NSI(:,:,3,:)))).^2,3));
% NSILog=20*log10(abs(abs(NSI(:,:,1))+abs(NSI(:,:,2))-2*abs(NSI(:,:,3))));
NSINorm=NSILog-max(NSILog,[],'all');
figure();subplot(1,2,1);imagesc(DASNorm,[-DR 0]);colormap('gray');title('DAS PD');
subplot(1,2,2);imagesc(NSINorm,[-DR 0]);colormap('gray');title('NSI PD');
end