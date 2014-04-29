% Initial variables
numberOfImages = 417; % Size of training data
pictureWidth = 64;                       
pictureHeight = 64;
resolution = pictureWidth * pictureHeight;
numberOfeigenFaces = 20;
faceToCompose = 2;  % Choose which face (number from 1 to n) to decompose into its eigenfaces
faces = double(faces);

% Calculates the average of all the faces
sumFaces = zeros(resolution,1);
for i = 1:length(faces(1,:))
    sumFaces(:,1) = sumFaces(:,1) + faces(:,i);
end
mean = sumFaces/numberOfImages;

% Calculates the difference between each face and the mean
for i = 1:numberOfImages
    deviation(:,i) = faces(:,i) - mean;
end

% Calculates the "covariance matrix" and its eigenstuff
L = transpose(deviation) * deviation;
[eigenvectors, eigenvalues] = eig(L);
eigenface = deviation * eigenvectors;

% Normalizes the eigenfaces
for i = 1:numberOfImages
    magnitude = sqrt(sum(eigenface(:,i).^2));
    eigenface(:,i) = eigenface(:,i) / magnitude;
end

% Calculates the weights
new_image = zeros(resolution,1);
for i = 1:numberOfeigenFaces
    weight = (double(faces(:,faceToCompose)) - mean);
    weight = transpose(eigenface(:,i)) * weight;
    weight
    new_image = new_image + weight * eigenface(:,i);
end

% Displays the new image
image_vector = mat2gray(new_image);
counter = 1;
for i = 1:pictureWidth
    for j = 1:pictureHeight
        image_matrix(j,i) = image_vector(counter);
        counter = counter + 1;
    end
end
imshow(image_matrix);