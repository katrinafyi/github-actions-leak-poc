# github-actions-leak-poc

This proof of concept demonstrates a kind of man-in-the-middle attack to obtain tokens
provided to actions/checkout, provided the target workflow allows you to run
arbitrary shell code before the checkout step.

This vulnerability&mdash;if you can even call it that&mdash;is obvious. 
The mitigation is to design the workflow so that, if executing user-provided code
is needed, that must only happen *after* any usages of sensitive values. 
The actions runner should be considered compromised after running
untrusted code.
