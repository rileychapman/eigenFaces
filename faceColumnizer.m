face_column = [];

for i = 1:1000
    face_vect = transpose(face16(1,:));
    face_column = [face_column; face_vect];
end

faces(:,17) = face_column;