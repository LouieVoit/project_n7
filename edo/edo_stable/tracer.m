function tracer()
    %Pour A1 et A2
    load A1.mat;
    load A2.mat;
    y01 = zeros(2,10);
    for j=1:10
        t=2*(j-1)*pi/10;
        y01(:,j) = [0.8;0.8]+0.3*[cos(t);sin(t)];
    end    
    tf=2*pi/sqrt(3);
    h=tf/99;
    t=0:h:tf;
    y1=zeros(2,100,10);
    y2=zeros(2,100,10);
    y1(:,1,:)=y01;
    y2(:,1,:)=y01;
    for j=2:100
         y1(:,j,:)=expm(t(j)*A1)*y01;
         y2(:,j,:)=expm(t(j)*A2)*y01;
    end   
    %Pour A3
    load A3.mat;
    y02 = zeros(2,10);
    for j=1:10
        t=2*(j-1)*pi/10;
        y02(:,j) = [0.15;-0.6]+0.1*[cos(t);sin(t)];
    end    
    tf=1;
    h=tf/99;
    t=0:h:tf;
    y3=zeros(2,100,10);
    y3(:,1,:)=y02;
    for j=2:100
         y3(:,j,:)=expm(t(j)*A3)*y02;
    end   
    %Plot
    figure;
    axis equal
    subplot(221);
    hold on;
    for k=1:10
        plot(y1(1,:,k),y1(2,:,k));
    end
    subplot(222);
    hold on;
    for k=1:10
        plot(y2(1,:,k),y2(2,:,k));
    end
    subplot(223);
    hold on;
    for k=1:10
        plot(y3(1,:,k),y3(2,:,k));
    end
    %Plot flot 1 et 2
    tf=2*pi/sqrt(3);
    h=tf/99;
    t=0:h:tf;
    iflot=linspace(1,100,10); %nombre de flot
    for i=iflot
        y01 = zeros(2,100);
        for j=1:100
            tc=2*(j-1)*pi/100;
            y01(:,j) = [0.8;0.8]+0.3*[cos(tc);sin(tc)];
        end 
        aux=expm(t(i)*A1)*y01;
        subplot(221);
        hold on;
        fill(aux(1,:),aux(2,:),'y');
        aux=expm(t(i)*A2)*y01;
        subplot(222);
        hold on;
        fill(aux(1,:),aux(2,:),'y');
    end  
    %Plot flot 3
    tf=1;
    h=tf/99;
    t=0:h:tf;
    iflot=floor(linspace(1,100,5)); %nombre de flot
    for i=iflot
        y02 = zeros(2,100);
        for j=1:100
            tc=2*(j-1)*pi/100;
            y02(:,j) = [0.15;-0.6]+0.1*[cos(tc);sin(tc)];
        end 
        aux=expm(t(i)*A3)*y02;
        subplot(223);
        hold on;
        fill(aux(1,:),aux(2,:),'y');
    end    
      
   