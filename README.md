# Language Assignment #3: Prolog
### Author: Jeff Kahn
## Run Instructions:
<body>
Meetcomplete:
<ol>
<li> Navigate to workspace directory</li>
<li>$ app gplc meetcomplete.pl</li>
<li>$ ./meetcomplete</li>
</ol> 
 
Meetone:
 
  1. Navigate to workspace directory
  2. $ app gplc meetone.pl
  3. $ ./meetone
 
## Description
The intention of this program was to develop a prolog program to understand the different paradigm that prolog represents when compared to imperative languages. To that end, two programs, meetone and meetcomplete were generated.

The first program, meetone, is a simplified version of the second. In it, the goal was to list the names of people in a data sheet that could meet during a given period of time.

Since a skeleton was given and it was a simplified version of part two, I'd like to be able to say that it went smoothly, but prolog could very well be a language written by and for aliens.

In the second program, meetcomplete, a list of people were given as a fact. From this fact, a list of compatible time periods that exist between each person was developed.

The introduction of a list containing a head and tail in the second part was every bit more complicated as one might expect. The only saving grace for this part was the car/cdr experience in Scheme and the lte developed from the simplified first program.
</body>
