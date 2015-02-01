
I = imread(filename);
I = I(:,:,1);
figure(1)
imshow(I);
m = select_init_mask(I);

m_cv = activecontour(I,m,1000);
figure(2)
imshow(m_cv);

m_e = activecontour(I,m,'edge');
figure(3)
imshow(m_e);

