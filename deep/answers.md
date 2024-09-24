# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

Adopting this approach ensures that no boat gets too much information, thus avoiding information overload (in the case when there are a lot of observations sent in a  short time interval).
However, this approach could also lead to mixing the information and making it more difficult to find consequent observations sent to the boats (observations sent one after the other), since you have to check all three boats.

## Partitioning by Hour

This approach, compared to the first one, makes it easier to find specific or consequent observations, since you only have to check some (or only one) boats.
However, there might be a case where there are a lot of observations in a specific time span (partition). Then, one boat will receive a lot of information, causing an information overload.

## Partitioning by Hash Value

This approach has the main benefit that it avoids information overload on specific boats, since observations get randomly-assigned hashes (evenly across all possible hash values). Also, the approach is useful when looking for a specific observation, since we can find its hash and, then, find its boat, thus searching in one boat only.
However, the disadvantage might be that you have to search on all boats for observations in a specific time interval.

