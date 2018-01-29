#Lab 6: Inductive Data Types

*CSci 2041: Advanced Programming Principles, Spring 2017*

**Due:** Friday, the 24th of February, at 5.00PM.    

This lab will focus on tree based inductive data types and on functions surrounding these. 

##PART A: 

For this part of the lab, use the following type for ``tree``:
```
type 'a tree = Leaf of 'a
             | Fork of 'a * 'a tree * 'a tree
```

Some examples using this: 
+ ``let t1 = Leaf 5``
+ ``let t2 = Fork (3, Leaf 3, Fork (2, t1, t1))``
+ ``let t3 = Fork ("Hello", Leaf "World", Leaf "!")``

Below are a list of functions that you will need to implement on this:

#### 1. ``t_size``
Given an 'a tree, write a function ``t_size`` to find the size of the tree. This function will be of the type: ``'a tree -> int``. 

Example: 
	``t_size t3`` gives ``int = 3``. 

#### 2. ``t_sum``
Given an int tree, write a function ``t_sum`` to find the sum of the values in the tree. The type of the function is: ``int tree -> int``.  

Example:
```	
	let t4 = Fork (7, Fork (5, Leaf 1, Leaf 2), Fork (6, Leaf 3, Leaf 4))
```
``t_sum t4`` gives ``int = 28``.

#### 3. ``t_charcount``
Write a function ``t_charcount`` that takes a string tree as input and count the total number of characters that the values contain. Type of the function is: ``string tree -> int``.   
Example: 
```
	t_charcount t3 gives int = 11. 
```

#### 4. ``t_concat``
Now, write a function ``t_concat`` that will concatenate together the values of a string tree. Type of this function is: ``string tree -> string``. 
Example: 
```
	t_concat t3 gives string = "HelloWorld!". 
```

##PART B: 

In this part, you will introduce options as well into the above tree type and handle those cases.

An example: 
```
let t5 : string option tree = Fork (Some "a", Leaf (Some "b"), Fork (Some "c", Leaf None, Leaf (Some "d"))). 
```
This is a tree of type ``string option tree``. 


Write 4 new functions, similar to the ones above, but that work over trees with ``option`` values in them
For example, ``t_opt_size`` should count the number of values in the tree that is under the "Some" constructor.
The types are as follows:  

1) ``t_opt_size : 'a option tree -> int``

Example: 
```
let t7 = (Fork (Some 1, Leaf (Some 2), Fork (Some 3, Leaf None, Leaf None)))
t_opt_size t7
```
gives 

```
int = 3
```


2) ``t_opt_sum : int option tree -> int``

Example: 
``t_opt_sum t7`` gives ``int = 6``.


3) ``t_opt_charcount : string option tree -> int``

Example: 
```
let t8 = (Fork (Some "a", Leaf (Some "b"), Fork (Some "c", Leaf None, Leaf (Some "d"))))
t_opt_charcount t8
```
gives
```
int = 4
```

4) ``t_opt_concat : string option tree -> string``

Example: 
```
t_opt_concat t8
```
gives
```
string = "abcd"
```

##PART C: 

In class, function ``tfold`` with type ``('a -> 'b) -> ('a -> 'b -> 'b -> 'b) -> 'a tree -> 'b`` was introduced. Here is the function: 
```
let rec tfold (l:'a -> 'b) (f:'a -> 'b -> 'b -> 'b)  (t:'a tree) : 'b = 
         match t with
         | Leaf v -> l v
         | Fork (v, t1, t2) -> f v (tfold l f t1) (tfold l f t2)
```
The next set of questions will require you to write all the questions in PART A and PART B using tfold and without using recursionss. 
Name and the type are as follows: 
```
1) tf_size : 'a tree -> int

2) tf_sum : int tree -> int

3) tf_char_count : string tree -> int

4) tf_concat : string tree -> string

5) tf_opt_size : 'a option tree -> int

6) tf_opt_sum : int option tree -> int

7) tf_opt_char_count : string option tree -> int

8) tf_opt_concat : string option tree -> string
```

##PART D: 

This is the final part of this lab. Instead of using the above tree, will we now use a tree of this type: 
```
type 'a btree = Empty
              | Node of 'a btree * 'a * 'a btree
```
This is a sorted tree, and will enable us to create empty trees as well as trees with size two. 

Using this tree type, do the following: 

#### ``bt_insert_by``
Write a function ``bt_insert_by`` that will take a comparator, an element and a btree as the input, and insert this element into the btree using the comparator to find the correct position. As the tree is sorted, the criteria to insert is as follows: 

1. the values in the left subtree is always less than or equal to the value of the Node. 
2. the values in the right subtree is always greater that the value of the Node.   

The following is the type: 
``bt_insert_by : ('a -> 'a -> int) -> 'a -> 'a btree -> 'a btree``
Example: 
```
	let t6 = Node (Node (Empty, 3, Empty), 4, Node (Empty, 5, Empty))
	bt_insert_by compare 6 t6
``` 
returns
```
	int btree = Node (Node (Empty, 3, Empty), 4, Node (Empty, 5, Node (Empty, 6, Empty)))
```

You can use the comparator found in the Pervasives (Pervasives.compare) module, but, ensure that you understand how it actually works, lest it inserts the element in the incorrect location. 

#### ``bt_elem_by``
Like in the homework, write a similar function ``bt_elem_by`` that will now take as inputs a function, an element and a btree, and return true if the element exists in the tree, or, false otherwise. The type of the function is: 
``bt_elem_by : ('a -> 'b -> bool) -> 'b -> 'a btree -> bool``

Example: 
```
	let t6 = Node (Node (Empty, 3, Empty), 4, Node (Empty, 5, Empty))
	bt_elem_by (=) 4 t6
```
returns ``true``

#### ``bt_to_list``
Create a function ``bt_to_list`` that will take as a btree and create a list of all the values in the btree. The type of the function is ``'a btree -> 'a list``. 
Example: ``bt_to_list t6`` will return 
	``int list = [3; 4; 5]``. 

#### ``btfold``
Like ``tfold``, now create a function ``btfold`` of the type ``'b -> ('b -> 'a -> 'b -> 'b) -> 'a btree -> 'b``. 

#### ``btf_elem_by``
Write ``btf_elem_by``  so that it has the same behaviour as ``bt_elem_by`` that you wrote above but this one must not be
recursive and must instead use ``btfold``.


#### ``btf_to_list``
Similarly, write a new function named ``btf_to_list``  that has the same behaviour as your ``bt_to_list`` function that you wrote above.  But now use ``btfold`` instead without recursion. Call this function ``btf_to_list``. 


#### ``btf_insert_by`` ? ?
Finally, write a comment on why will using ``btfold`` for ``bt_insert_by`` might be difficult. 
