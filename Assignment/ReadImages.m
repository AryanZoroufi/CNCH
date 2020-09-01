function [star, triangle] = ReadImages(wPtr)
File_Directory = pwd;
cd([File_Directory,'/Images']);
star_pic =  imread('star.png'); 
triangle_pic = imread('triangle.png');
star = Screen('MakeTexture',wPtr,star_pic);
triangle = Screen('MakeTexture',wPtr,triangle_pic);
end