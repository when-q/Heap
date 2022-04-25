using Heap
using Random
using Test

const heap1 = 
"""
88 17 45 16 17 30 8 13 2 16 9 4
"""
const heap2 =
"""
15 13 9 4 7
"""

x = [88,17,45,16,17,30,8,13,2,16,9,4]
y = [15, 13, 9, 4, 7] 
# feel free to add more test cases

@testset "Heap.input" begin
	@test Heap.input(IOBuffer(heap1)) == x
	@test Heap.input(IOBuffer(heap2)) == y
end

@testset "Heap.build_max_heap" begin
#	x1 = Heap.input(IOBuffer(heap1))
	x1 = (shuffle ∘ Heap.input)(IOBuffer(heap1))
	y1 = (shuffle ∘ Heap.input)(IOBuffer(heap2))
	@test (Heap.is_valid_max_heap∘Heap.build_max_heap )(x1)  == true
	@test (Heap.is_valid_max_heap∘Heap.build_max_heap )(y1)  == true
end

@testset "Heap.max_heap_insert" begin
	
	x1 = [88,17,48,16,17,45,8,13,2,16,9,4, 30]
	y1 = [48, 13, 15, 4, 7, 9] 
	@test Heap.max_heap_insert(Heap.input(IOBuffer(heap1)), 48) == x1
	@test Heap.max_heap_insert(Heap.input(IOBuffer(heap2)), 48) == y1
end

@testset "Heap.max_heapify" begin
	x1 = [48,17,30,16,17,45,8,13,2,16,9,4]
	y1 = [15, 4, 9, 13, 7, 48] 
	# using python indexing
	@test Heap.max_heapify(x1, 2, Heap.height(x1[length(x1)])) == [48,17,45,16,17,30,8,13,2,16,9,4]
	@test Heap.max_heapify(y1, 2, Heap.height(y1[length(y1)])) == [15, 4, 48, 13, 7, 9]
end

