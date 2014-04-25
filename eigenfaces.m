numberOfImages = 400;                       
pictureWidth = 64;                       
pictureHeight = 64;
resolution = pictureWidth * pictureHeight;
numberOfeigenFaces = 15;
faceToCompose = 1;  % Choose which face (number from 1 to n) to decompose into its eigenfaces


% Calculates the average of all the faces
sum = zeros(resolution,1);
for i = 1:length(faces(1,:))
    sum(:,1) = sum(:,1) + faces(:,i);
end
mean = sum/numberOfImages;

% Calculates the difference between each face and the mean
for i = 1:numberOfImages
    deviation(:,i) = faces(:,i) - mean;
end

% Calculates the "covariance matrix" and its eigenstuff
L = transpose(deviation) * deviation;
[eigenvectors, eigenvalues] = eig(L);

% Orders the eigenvectors by strongest to weakest
for i = 1:length(eigenvectors)
    eigenvectors_ordered(:,i) = eigenvectors(:,(numberOfImages+1-i));
end

% Calculates the first 100 eigenfaces
for i = 1:numberOfeigenFaces
    eigenface(:,i) = deviation * eigenvectors_ordered(:,i);
end

% Displays the image
new_image = zeros(resolution,1);
for i = 1:numberOfeigenFaces
    weight = (double(faces(:,faceToCompose)) - mean);
    weight = transpose(eigenface(:,i)) * weight;
    new_image = new_image + weight * eigenface(:,i);
end

image_vector = mat2gray(new_image);
counter = 1;
for i = 1:pictureWidth
    for j = 1:pictureHeight
        image_matrix(j,i) = image_vector(counter);
        counter = counter + 1;
    end
end
imshow(image_matrix)