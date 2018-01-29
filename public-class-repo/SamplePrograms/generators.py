# Below, squares_to defines a "generator".
# This is a type of coroutine whose execution
# interleaves with the code retrieving values
# out of this generator.
def squares_to(n):
    num = 0
    while num <= n:
        print ("generating another square, this time for %d" % num)
        yield (num*num)
        num += 1

# Here is the code that pulls values out of
# the generator.  Note the the print statements
# will alternate in the output.  This is becuase
# control alternates back and forth between the
# generator in squares_to and the loop below.
for n in squares_to(10):
    print("printing the next square: %d" % n)


# We implemented lazy streams in OCaml that can be
# used to the same effect.
