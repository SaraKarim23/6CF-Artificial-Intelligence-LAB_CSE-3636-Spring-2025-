# 🧠 A* Maze Solver with Pyamaze

This project visualizes the *A\** (A-star) pathfinding algorithm in a randomly or custom-generated maze using the pyamaze Python library. It demonstrates how A\* works by showing the search path, the visited nodes, and the final optimal path from the start cell to the goal cell.

---

## 📌 Features

- Maze generation (random or from .csv file)
- Visualization of:
  - ✅ Nodes explored during A\* search
  - ✅ Complete search tree
  - ✅ Final shortest path
- Customizable start and goal positions
- Colored agents to distinguish between search, path, and result
- Path length and search length statistics shown in real-time

---

## 🔍 Screenshot

Here is a sample output showing the A\* algorithm in action:

![A* Maze Screenshot](./screenshot.png)  
Blue: Search path · Yellow: Full A path · Red: Final shortest path*

> Replace screenshot.png with your actual image filename if different.

---

## 🛠 Technologies Used

- *Python 3*
- *Pyamaze* (maze generation & animation)
- *PriorityQueue* (for A\* algorithm)

---

## 🧪 How It Works

1. The maze is either generated randomly or loaded from a file.
2. The A\* algorithm begins at a start cell and explores all possible paths based on cost and heuristic (Manhattan distance).
3. The algorithm keeps track of:
   - Total cost (g_score)
   - Estimated total cost (f_score)
   - Backtracking path (aPath)
4. Once the goal is reached, the shortest path is reconstructed.

---

## 🧭 Agent Color Legend

| Agent Color | Meaning                  |
|-------------|--------------------------|
| 🔵 Blue      | Visited cells (search path) |
| 🟡 Yellow    | Entire A\* search tree     |
| 🔴 Red       | Final shortest path        |

---

## 📂 File Structure
AStarMazeSolver/
1. aStardemo.csv         # (Optional) Predefined maze file to load
2.  main.py               # Main Python script containing the A* algorithm
3. screenshot.png        # Screenshot showing the path visualization (you can replace with your own)
4. README.md             # This project documentation
