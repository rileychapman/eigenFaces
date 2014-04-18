numberOfImages = 17;
pictureWidth = 1000;
pictureHeight = 1000;
resolution = pictureWidth * pictureHeight;
numberOfeigenFaces = 15;
faceToCompose = 5;


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
    weight = (double(eigenface(:,1)) - mean);
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