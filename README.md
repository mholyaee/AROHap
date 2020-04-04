# AROHap
AROhap is a useful program to reconstruct haplotype sequences. This method involves two steps:
First, like FasHap [1] method, constructs a fuzzy conflict graph based on the similarity of input fragments and provides an initial bi-partitioning. Second, use Asexual reproduction optimization algorithm as a fast convergence speed evoulotionary based method, to improves the inital partitioning.

These features not only enhance reconstruction rate but also improve the running time of the method.

### You can access to our published article from:

https://www.sciencedirect.com/science/article/pii/S1476927116305369

# Requirement:

This program is suitable for MATLAB R2013a and above versions.
The program has adopted by Geraci's dataset. By some little change it can be used for any input data.

# Running AROHap

For this purpose it is only need to run AROhap.m file.

The obtained results which includes the reconstruction rate and running time will be saved in some text files on the current path.

The details of used dataset can be accessible in the below paper:

F. Geraci, "A comparison of several algorithms for the single individual SNP haplotyping reconstruction problem," Bioinformatics, vol. 26, pp. 2217-2225, 2010.

Finally, some interesting methods, such as FastHap[1] and GAHap[2] have been implemented in Matlab which can be used with the same name.

[1] S. Mazrouee and W. Wang, "FastHap: fast and accurate single individual haplotype reconstruction using fuzzy conflict graphs," published in Bioinformatics, vol. 30, pp. i371-i378, 2014.

[2] T.-C. Wang, J. Taheri, and A. Y. Zomaya, "Using genetic algorithm in reconstructing single individual haplotype with minimum error correction," published in Journal of biomedical informatics, vol. 45, pp. 922-930, 2012.

# Feedback

Its pleasure for me to have your comment.
mh.olyaee@gmail.com
