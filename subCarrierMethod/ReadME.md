# Sub Carrier Method

This contains Theta Values for all Users using the Sub Carrier Method. Essentially, we sort using the Subcarrier powers and take the first _max_iter_per_loop_ values, and see if the Rate increases for changes in these values.

## Further Improvements :

1. Use some Percentage of the Power and Take Values above it.

2. Improve this Algorithm by considering Pairs of Values (That were changed induvidually), to kinda model it like the Apriori Algorithm.

3. See if changing the  _max_iter_per_loop_ variable changes the output by a large margin
