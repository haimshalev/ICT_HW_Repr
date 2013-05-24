function [ WhiteBlackRedPic ] = RedRecognition_2(OriginalPic_RGB)


for mm = 1:size(OriginalPic_RGB,1)
    for nn = 1:size(OriginalPic_RGB,2)
        if OriginalPic_RGB(mm,nn,1) < 80 || OriginalPic_RGB(mm,nn,2) > 80 || OriginalPic_RGB(mm,nn,3) > 100
            gsc = 0.3*OriginalPic_RGB(mm,nn,1) + 0.59*OriginalPic_RGB(mm,nn,2) + 0.11*OriginalPic_RGB(mm,nn,3);
            OriginalPic_RGB(mm,nn,:) = [gsc gsc gsc];
        end
    end
end

WhiteBlackRedPic = OriginalPic_RGB;

end