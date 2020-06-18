import Foundation
import Swift 
class TrieNode {
    var child = [Character : TrieNode]()
    var leaf: Bool
    init() {
        leaf = false
    }
}

func insert_word(root: TrieNode, key: String) {
    var pChild = root
    for c in key {
        if (pChild.child[c] == nil) {
            pChild.child[c] = TrieNode()
        }
        pChild = pChild.child[c] ?? TrieNode()
    }
    pChild.leaf = true
}

var output_word: Set<String> = []
func search_word(root: TrieNode, table: [[Character]], i: Int, j: Int, M: Int, N: Int, v_home: inout [[Bool]],str: String) {
  if(root.leaf == true) {
    if(!output_word.contains(str)) {
      print(str)
      output_word.insert(str)
    }
  }
  if(i >= 0 && i < M && j >= 0 && j < N && !v_home[i][j]){
    v_home[i][j] = true
    for n in root.child {
      if(i - 1 >= 0 && i - 1 < M && j - 1 >= 0 && j - 1 < N && !v_home[i - 1][j - 1] && n.key == table[i - 1][j - 1]) {
        search_word(root: n.value,table: table,i: i - 1,j: j - 1,M: M,N: N,v_home: &v_home,str: str + String(n.key))
      } // 1

      if(i >= 0 && i < M && j - 1 >= 0 && j - 1 < N && !v_home[i][j - 1] && n.key == table[i][j - 1]) {
        search_word(root: n.value,table: table,i: i,j: j - 1,M: M,N: N,v_home: &v_home,str: str + String(n.key))
      } // 2

      if(i + 1 >= 0 && i + 1 < M && j - 1 >= 0 && j - 1 < N && !v_home[i + 1][j - 1] && n.key == table[i + 1][j - 1]) {
        search_word(root: n.value,table: table,i: i + 1,j: j - 1,M: M,N: N,v_home: &v_home,str: str + String(n.key))
      } // 3

      if(i - 1 >= 0 && i - 1 < M && j >= 0 && j < N && !v_home[i - 1][j] && n.key == table[i - 1][j]) {
        search_word(root: n.value,table: table,i: i - 1,j: j,M: M,N: N,v_home: &v_home,str: str + String(n.key))
      } // 4

      if(i + 1 >= 0 && i + 1 < M && j >= 0 && j < N && !v_home[i + 1][j] && n.key == table[i + 1][j]) {
        search_word(root: n.value,table: table,i: i + 1,j: j,M: M,N: N,v_home: &v_home,str: str + String(n.key))
      } // 5

      if(i - 1 >= 0 && i - 1 < M && j + 1 >= 0 && j + 1 < N && !v_home[i - 1][j + 1] && n.key == table[i - 1][j + 1]) {
        search_word(root: n.value,table: table,i: i - 1,j: j + 1,M: M,N: N,v_home: &v_home,str: str + String(n.key))
      } // 6

      if(i >= 0 && i < M && j + 1 >= 0 && j + 1 < N && !v_home[i][j + 1] && n.key == table[i][j + 1]) {
        search_word(root: n.value,table: table,i: i,j: j + 1,M: M,N: N,v_home: &v_home,str: str + String(n.key))
      } // 7

      if(i + 1 >= 0 && i + 1 < M && j + 1 >= 0 && j + 1 < N && !v_home[i + 1][j + 1] && n.key == table[i + 1][j + 1]) {
        search_word(root: n.value,table: table,i: i + 1,j: j + 1,M: M,N: N,v_home: &v_home,str: str + String(n.key))
      } // 8
    }
    v_home[i][j] = false  
  }
}

func find_word(table: [[Character]], root: TrieNode, M: Int, N: Int) {
  var v_home = Array(repeating: Array(repeating: false, count: N), count: M)
  var pChild = root
  var str: String
  str = ""
  for i in 0...(M-1) {
      for j in 0...(N-1) {
          if (pChild.child[table[i][j]] != nil) {
              str.append(table[i][j])
              search_word(root: pChild.child[table[i][j]] ?? TrieNode(),table: table,i: i,j: j,M: M,N: N,v_home: &v_home,str: str)
              str = ""
          } 
      }
  }
}

let line1 = readLine()!.components(separatedBy: " ")
let line2 = readLine()!.components(separatedBy: " ")

let M: Int
M = Int(line2[0]) ?? 1
let N: Int 
N = Int(line2[1]) ?? 1

var table : [[Character]] = [] 
for i in 1...M{
    table.append(readLine()!.characters.split {$0 == " "}.map{Character(String($0))})
}

let trie = TrieNode()
for i in 0...(line1.count - 1){
    insert_word(root: trie, key: line1[i])
} 

find_word(table: table, root: trie, M: M, N: N)