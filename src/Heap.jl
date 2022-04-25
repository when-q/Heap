module Heap

using Documenter
using Test

export build_max_heap,max_heap_insert, max_heapify, heap_extract_max, heap_max

"""
	indexing(i, j)::Int64
Giving the depth and the position of the element on that level, 
returning the index of it in the array

Heap: 
```
0     a
1   b   c
2  d f g h 
```

Array: `[a,b,c,d,e,f,g,h]`

To find the position of f:
`index(i=2, j=2) \rightarrow  6`
"""
@inline indexing(i::Int64, j::Int64) = begin
	# julia uses 1 indexing
	# for conveniance I will hide them from the outputs
	# You do not have to worry about that
	2^i+j-2
end


"""
	height(i::Int64)::Int64
-----
get the height of current obj on the heap
"""
@inline height(i::Int64) = begin
	i !=0 ? convert(Int64, ceil(log(i)))+1 : 0
end

"""
	swap(arr::Vector{Int64}, i::Int64, j::Int64)
swap values of two elements in an array
"""
@inline swap(arr::Vector{Int64}, i::Int64, j::Int64) = begin
	arr[convert_index(i)], arr[convert_index(j)] = arr[convert_index(j)], arr[convert_index(i)]
end


"""
	convert_index(i::Int64)
-----
convert python index to julia index
"""
@inline convert_index(i::Int64) = begin
	i+1
end


"""
	parent(i::Int64, h::Int64)
-----
return the parent of current obj on the heap
"""
@inline parent(i::Int64, h::Int64) = begin
	t = i - 2^(h)
	i % 2 == 0  ? (t-2)/2 + 2^(h-1) : (t - 1)/2 + 2^(h - 1)
end

"""
	input(io::IO)::Vector{Int64}

------
convert an io input into a vector
"""
function input(io::IO)::Vector{Int64}
	input = readline(io) 
	m = [parse(Int64, ss) for ss in split(input, " ")]
	return m
end

"""
	heap_extract_max(arr::Vector{Int64})
-----
Return (and delete) the maximum item of a Heap in
``O(lg(n))`` time
"""
function heap_extract_max(arr::Vector{Int64})
	popat!(x, getindex(x, maximum(x)))
end

"""
	heap_max(arr::Int64)
------
Returns the max element of a Heap - Θ(1) time.
"""
function heap_max(arr::Int64)
	return max(arr)
end


"""
	max_heapify(arr::Vector{Int64}, index::Int64, depth::Int64)
------
Runs in ``O(lg(n))`` time and is used to maintain the (max) Heap
property whenever some node/index i has violated the heap rule
(but left subtree, right subtree are each Max Heaps)
"""
function max_heapify(arr::Vector{Int64}, index::Int64, depth::Int64)
	h = height(index)
	if h == depth
		# if leaf we stop
		return
	end
	i = arr[convert_index(index)]
	left_index = 2^(h+1)-1 + (index-(2^h-1))*2
	right_index = left_index + 1

	# out of bound handling
	l = left_index < length(arr) ? arr[convert_index(left_index)] : -Inf
	r = right_index < length(arr) ? arr[convert_index(right_index)] : -Inf

	if i < l || i < r
		# should i swap with childs?
		if l > r
			# swap i with l?
			swap(arr, index, left_index)

			max_heapify(arr, left_index, depth)
		else
			# swap i with r ?
			swap(arr,  index, right_index)
			max_heapify(arr, right_index , depth)
		end
	end
	return arr
end

"""
	max_heap_insert(arr::Vector{Int64},k::Int64)
-----
an insert a new item (and maintain the heap property) 
in ``O(lg(n))`` time. 

Same for Heap-Increase-Key
"""
function max_heap_insert(arr::Vector{Int64},k::Int64)

	j = length(arr)	
	push!(arr, k)

	while j ≠ 0

		h =  height(j)
		p = convert(Int, parent(j,h))

		if arr[convert_index(j)] ≤ arr[convert_index(p)]
			break
		end

		swap(arr, j, p)
		j = p
	end
	return arr
end

"""
	is_valid_max_heap(arr::Vector{Int64})
-----
Check whether an array is a heap
"""
function is_valid_max_heap(arr::Vector{Int64})
	
	for index in 0:length(arr)-1
		h = height(index)
		left_index = 2^(h+1)-1 + (index-(2^h-1))*2
		right_index = left_index + 1
		b::Bool= true
		# out of bound handling
		l = left_index < length(arr) ? arr[convert_index(left_index)] : -Inf
		r = right_index < length(arr) ? arr[convert_index(right_index)] : -Inf

		if l == -Inf || r == -Inf
			 b = True
		end
		if arr[convert_index(index)] > arr[convert_index(left_index)] &&
			arr[convert_index(index)] > arr[convert_index(right_index)]
			b = true
		else
			return false
		end
		return b
	end
end


"""
	build_max_heap(arr::Vector{Int64})
-----
Special one called Build-Max-Heap will run in O(n) time to
build a Heap from scratch from an unordered input array.
"""
function build_max_heap(arr::Vector{Int64})
	size = length(arr)
	h = height(arr[size])
	for i in convert(Int64, floor(size/2)) - 1: -1: 0
		max_heapify(arr, i, h)
	end
	return arr
end

#println(build_max_heap(open(input, "input")))
#print(is_valid_max_heap(build_max_heap(open(input, "input"))))

end
