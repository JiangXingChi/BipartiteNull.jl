## <center>BipartiteNul.jl</center>
### Overview
BipartiteNull.jl is a tool for building null model of bipartite network. This work refers to the R package bipartite.
### Install
* Install this package by Github:
```julia
using Pkg;
Pkg.add(PackageSpec(url="https://github.com/JiangXingChi/BipartiteNull.jl"))
```
* Install this package by Gitee:
```julia
using Pkg;
Pkg.add(PackageSpec(url="https://gitee.com/pandalinux/bipartite-null.jl"))
```
### Example
Example1:
```
using BipartiteNull,DataFrames;
data=ExampleData(2);
print(data);
df=NullNetworkLevel(data)
```
### Function
#### Data handling
##### ExampleData
```julia
`ExampleData(order::Int)`
Some simple examples.
# Argument
* `order`:1~6.
# Return
* `data`:One dataframe.
# Example
using BipartiteNull,DataFrames;
data=ExampleData(1)
```
##### ReadCSV
```julia
`ReadCSV(file::String)`
Read the csv file and convert it to dataframe.
# Argument
* `file`:File name (including path).
# Return
* `data`:One dataframe.
```
##### RmZeroCol
```julia
`RmZeroCol(data::DataFrame)`
Delete all 0 columns.
# Argument
* `data`:Adjacency matrix of a bipartite network.
# Return
* `newdata`:The columns that are all 0 are deleted on the basis of data.
# Example
using BipartiteNull,DataFrames;
data=ExampleData(1);
print(data);
newdata=RmZeroCol(data)
```
##### RmZeroRow
```julia
`RmZeroRow(data::DataFrame)`
Delete all 0 rows.
# Argument
* `data`:Adjacency matrix of a bipartite network.
# Return
* `newdata`:The rows that are all 0 are deleted on the basis of data.
# Example
using BipartiteNull,DataFrames;
data=ExampleData(1);
print(data);
newdata=RmZeroRow(data)
```
##### Weight2Bool
```julia
`Weight2Bool(data::DataFrame)`
Convert weight values in the matrix to Boolean values.
# Argument
* `data`:Weight adjacency matrix of a bipartite network.
# Return
* `newdata`:Boolean adjacency matrix of a bipartite network.
# Example
using BipartiteNull,DataFrames;
data=ExampleData(5);
print(data);
newdata=Weight2Bool(data)
```
##### SampleVector
```julia
`SampleVector(v::Vector)`
Reorder.
# Argument
* `v`:Vector.
# Return
* `vnull`:New vector.
# Example
using BipartiteNull;
v=[1,2,3,4,5,6,7,8,9];
print(v);
vnull=SampleVector(v)
```
##### Coin
```julia
`Coin(pvalue::Float64)`
Output true by probability
# Argument
* `pvalue`:Probability of true output(greater than 0 but less than 1).Please enter the value to one decimal place or two decimal places.
# Return
* `Bool`:2 values, true or false.
# Example
using BipartiteNull;
Coin(0.5)
```
##### CoinTest
```julia
`CoinTest(pvalue::Float64,testnumber::Int)`
Test Coin function.
# Argument
* `pvalue`:Probability of true output(greater than 0 but less than 1).Please enter the value to one decimal place or two decimal places.
* `testnumber`:Test number.
# Return
* `Bool`:The frequency of true is theoretically close to pvalue.
# Example
using BipartiteNull;
CoinTest(0.5,100000)
```
##### Row2Edge
```julia
`Row2Edge(data::DataFrame)`
Convert nodes represented by rows to edges.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `newdata`:One-mode network after projection.
# Example
using BipartiteNull,DataFrames;
data=ExampleData(6);
print(data);
newdata=Row2Edge(data)
```
##### Col2Edge
```julia
`Col2Edge(data::DataFrame)`
Convert nodes represented by columns to edges.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `newdata`:One-mode network after projection.
# Example
using BipartiteNull,DataFrames;
data=ExampleData(6);
print(data);
newdata=Col2Edge(data)
```
##### Splicing4Matrix
```julia
`Splicing4Matrix(data::DataFrame)`
The bipartite network is expanded into a one-mode network through matrix splicing.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `newdata`:One-mode network after splicing.
# Example
using BipartiteNull,DataFrames;
data=ExampleData(6);
print(data);
newdata=Splicing4Matrix(data)
```
##### Bipartite2Graph
```julia
`Bipartite2Graph(data::DataFrame,model::String)`
Convert the adjacency matrix of the bipartite network into the network structure under Graphs.jl through projection or expansion.
# Argument
* `data`:The adjacency matrix of a bipartite network.
* `fun`:Select the conversion method and support three functions:"Row2Edge","Col2Edge","Splicing4Matrix".
# Return
* `omm`:One-mode matrix by projection or expansion.
* `graph`:The network structure under Graphs.jl.
# Example
using BipartiteNull,DataFrames,Graphs;
data=ExampleData(6);
print(data);
omm,graph=Bipartite2Graph(data,"Row2Edge")
```
#### Bipartite network attributes 
##### Connectance
```julia
`Connectance(data::DataFrame)`
Realised proportion of possible links.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `value`:Connectance value.
# Example
using BipartiteNull,DataFrames;
data=ExampleData(6);
print(data);
value=Connectance(data)
```
##### LinksPerSpecies
```julia
`LinksPerSpecies(data::DataFrame)`
Sum of links divided by number of species(consider the overall and individual situation).
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `all`:Sum of links divided by number of all species.
* `agroup`:Sum of links divided by number of the species of rows.
* `bgroup`:Sum of links divided by number of the species of columns.
# Example
using BipartiteNull,DataFrames;
data=ExampleData(6);
print(data);
all,agroup,bgroup=LinksPerSpecies(data)
```
##### Cscore
```julia
`Cscore(data::DataFrame)`
Calculate checkerboard units.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `all`:Checkerboard units/2*2 units.
* `agroup`:C score of the species of rows.
* `bgroup`:C score of the species of columns.
# Example
using BipartiteNull,DataFrames,Graphs;
data=ExampleData(2);
print(data);
all,agroup,bgroup=Cscore(data)
```
##### GlobalClusterCoefficient
```julia
`GlobalClusterCoefficient(data::DataFrame)`
Calculate the global cluster coefficient of the bipartite network.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `agroup`:Global cluster coefficient of the species of rows.
* `bgroup`:Global cluster coefficient of the species of columns.
# Example
using BipartiteNull,DataFrames,Graphs;
data=ExampleData(6);
print(data);
agroup,bgroup=GlobalClusterCoefficient(data)
```
##### GlobalClusterCoefficientQuaternion
```julia
`GlobalClusterCoefficientQuaternion(data::DataFrame)`
Calculate the global cluster coefficient(quaternion) of the bipartite network.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `value`:Global cluster coefficient(quaternion).
# Example
using BipartiteNull,DataFrames,Graphs;
data=ExampleData(3);
print(data);
vlaue=GlobalClusterCoefficientQuaternion(data)
```
##### MeanLocalClusteringCoefficient
```julia
`MeanLocalClusteringCoefficient(data::DataFrame)`
Calculate the local cluster coefficient of the bipartite network.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `agroup`:Local cluster coefficient of the species of rows.
* `bgroup`:Local cluster coefficient of the species of columns.
# Example
using BipartiteNull,DataFrames,Graphs;
data=ExampleData(6);
print(data);
agroup,bgroup=MeanLocalClusteringCoefficient(data)
```
##### ModularityLabelPropagation
```julia
`ModularityLabelPropagation(data::DataFrame)`
Calculate the modularity by label propagation.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `all`:Modularity of all species.
* `agroup`:Modularity of the species of rows.
* `bgroup`:Modularity of the species of columns.
# Example
using BipartiteNull,DataFrames,Graphs;
data=ExampleData(1);
print(data);
all,agroup,bgroup=ModularityLabelPropagation(data)
```
#### Vertex attributes 

##### LocalClusteringCoefficient
```julia
`LocalClusteringCoefficient(data::DataFrame)`
Calculate the local cluster coefficient of the bipartite network.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `agroup`:Local cluster coefficient of the species of rows.
* `bgroup`:Local cluster coefficient of the species of columns.
# Example
using BipartiteNull,DataFrames,Graphs;
data=ExampleData(6);
print(data);
agroup,bgroup=LocalClusteringCoefficient(data)
```
##### LabelPropagation
```julia
`LabelPropagation(data::DataFrame)`
Mark the label by label propagation.
# Argument
* `data`:The adjacency matrix of a bipartite network.
* `maxiter`:Return after maxiter iterations if convergence has not completed.
# Return
* `newlabel`:Vertex and label information.
# Example
using BipartiteNull,DataFrames,Graphs;
data=ExampleData(1);
print(data);
newlabel=LabelPropagation(data)
```
##### BetweennessCentrality
```julia
`BetweennessCentrality(data::DataFrame)`
Calculate the betweenness centrality of the bipartite network.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `all`:Betweenness centrality of all species.
* `agroup`:Betweenness centrality of the species of rows.
* `bgroup`:Betweenness centrality of the species of columns.
# Example
using BipartiteNull,DataFrames,Graphs;
data=ExampleData(1);
print(data);
all,agroup,bgroup=BetweennessCentrality(data)
```
##### ClosenessCentrality
```julia
`ClosenessCentrality(data::DataFrame)`
Calculate the closeness centrality of the bipartite network.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `all`:Closeness centrality of all species.
* `agroup`:Closeness centrality of the species of rows.
* `bgroup`:Closeness centrality of the species of columns.
# Example
using BipartiteNull,DataFrames,Graphs;
data=ExampleData(1);
print(data);
all,agroup,bgroup=ClosenessCentrality(data)
```
##### DegreeCentrality
```julia
`DegreeCentrality(data::DataFrame)`
Calculate the degree centrality of the bipartite network.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `all`:Degree centrality of all species.
* `agroup`:Degree centrality of the species of rows.
* `bgroup`:Degree centrality of the species of columns.
# Example
using BipartiteNull,DataFrames,Graphs;
data=ExampleData(1);
print(data);
all,agroup,bgroup=DegreeCentrality(data)
```
#### Null model
##### Null1
```julia
`Null1(data::DataFrame)`
Null model 1, the constraint condition is that the number of species remains unchanged and the connectivity remains unchanged.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `nulldata`:Dataframe generated by null model 1.
# Example
using BipartiteNull,DataFrames;
data=ExampleData(7);
print(data);
nulldata=Null1(data)
```
##### Null2
```julia
`Null2(data::DataFrame,coinpvalue::Float64)`
Keep the degree distribution of the original node unchanged.
# Argument
* `data`:The adjacency matrix of a bipartite network.
* `coinpvalue`:Probability of true output(greater than 0 but less than 1).Please enter the value to one decimal place or two decimal places.
# Return
* `nulldata`:Dataframe generated by null model 2.
# Example
using BipartiteNull,DataFrames;
data=ExampleData(7);
print(data);
nulldata=Null2(data,0.5)
```
#### Result integration
##### NetworkLevel
```julia
`NetworkLevel(data::DataFrame,ID="-")`
Integration of some indicators of the bipartite network.
# Argument
* `data`:The adjacency matrix of a bipartite network.
# Return
* `df`:Integration of some indicators of the bipartite network.
# Example
using BipartiteNull,DataFrames;
data=ExampleData(7);
print(data);
df=NetworkLevel(data,"original")
```
##### NullNetworkLevel
```julia
`NullNetworkLevel(data::DataFrame;num=100,fun="Null2",coinpvalue=0.5)`
Integration of some indicators of the bipartite network(original and null model).
# Argument
* `data`:The adjacency matrix of a bipartite network.
* `num`:Generated quantity of null model.
* `fun`:Generation method of null model.
* `coinpvalue`:Probability of true output(greater than 0 but less than 1).Please enter the value to one decimal place or two decimal places.
# Return
* `df`:Integration of some indicators of the bipartite network(original and null model).
# Example
using BipartiteNull,DataFrames;
data=ExampleData(2);
print(data);
df=NullNetworkLevel(data)
```