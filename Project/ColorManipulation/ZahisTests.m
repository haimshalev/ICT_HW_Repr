%% Convert red flowers to blue flowers
bTestThis = false;

if bTestThis
    RedFlowers_RGB = imread('natural_flowers.bmp');

    BlueFlowers_YIQ_1 = RedBlueSwap_YIQ_1(RedFlowers_RGB);
    PlotDaltonization(RedFlowers_RGB,BlueFlowers_YIQ_1,'Convert Red to Blue (YIQ 1');

    BlueFlowers_RGB_1 = RedBlueSwap_RGB_1(RedFlowers_RGB);
    PlotDaltonization(RedFlowers_RGB,BlueFlowers_RGB_1,'Convert Red to Blue (RGB 1');

    BlueFlowers_LAB_1 = RedBlueSwap_LAB_1(RedFlowers_RGB);
    PlotDaltonization(RedFlowers_RGB,BlueFlowers_LAB_1,'Convert Red to Blue (LAB 1');

    BlueFlowers_LAB_2 = RedBlueSwap_LAB_2(RedFlowers_RGB);
    PlotDaltonization(RedFlowers_RGB,BlueFlowers_LAB_2,'Convert Red to Blue (LAB 2');

    BlueFlowers_LAB_3 = RedBlueSwap_LAB_3(RedFlowers_RGB);
    PlotDaltonization(RedFlowers_RGB,BlueFlowers_LAB_3,'Convert Red to Blue (LAB 3');   
end


%% Convert red market to blue market 
bTestThis = false;

if bTestThis
    Market_RGB = imread('Market.bmp');

    BlueMarket_YIQ_1 = RedBlueSwap_YIQ_1(Market_RGB);
    PlotDaltonization(Market_RGB, BlueMarket_YIQ_1, 'Convert Red to Blue (YIQ 1');

    BlueMarket_RGB_1 = RedBlueSwap_RGB_1(Market_RGB);
    PlotDaltonization(Market_RGB, BlueMarket_RGB_1, 'Convert Red to Blue (RGB 1');

    BlueMarket_LAB_1 = RedBlueSwap_LAB_1(Market_RGB);
    PlotDaltonization(Market_RGB, BlueMarket_LAB_1, 'Convert Red to Blue (LAB 1');

    BlueMarket_LAB_2 = RedBlueSwap_LAB_2(Market_RGB);
    PlotDaltonization(Market_RGB, BlueMarket_LAB_2, 'Convert Red to Blue (LAB 2');

    BlueMarket_LAB_3 = RedBlueSwap_LAB_3(Market_RGB);
    PlotDaltonization(Market_RGB, BlueMarket_LAB_3, 'Convert Red to Blue (LAB 3');
end


%% Flowers Red Recognition  test
bTestThis = false;

if bTestThis
    RedFlowers_RGB = imread('natural_flowers.bmp');

    OnlyRedFlowers_RGB_1 = RedRecognition_1(RedFlowers_RGB);
    figure; imshow(OnlyRedFlowers_RGB_1);
    OnlyRedFlowers_RGB_2 =  RedRecognition_2(RedFlowers_RGB);
    figure; imshow(OnlyRedFlowers_RGB_2);
    OnlyRedFlowers_RGB_3 = RedRecognition_3(RedFlowers_RGB);
    figure; imshow(OnlyRedFlowers_RGB_3);
    OnlyRedFlowers_RGB_4 = RedRecognition_4(RedFlowers_RGB);
    figure; imshow(OnlyRedFlowers_RGB_4);
end


%% Market Red Recognition  test
bTestThis = false;

if bTestThis
    Market_RGB = imread('Market.bmp');
    
    OnlyRedMarket_RGB_1 = RedRecognition_1(Market_RGB);
    figure; imshow(OnlyRedMarket_RGB_1);
    OnlyRedMarket_RGB_2 = RedRecognition_2(Market_RGB);
    figure; imshow(OnlyRedMarket_RGB_2);
    OnlyRedMarket_RGB_3 = RedRecognition_3(Market_RGB);
    figure; imshow(OnlyRedMarket_RGB_3);
    OnlyRedMarket_RGB_4 = RedRecognition_4(Market_RGB);
    figure; imshow(OnlyRedMarket_RGB_4)  
end


%% new test
Daltonize_1(imread('Market.bmp'));




























