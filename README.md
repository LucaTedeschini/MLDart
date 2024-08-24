# 🎨 SketchWizard Dart Library

Welcome to the **SketchWizard** Dart library! This library 🧙‍♂️ allows you to create a "Wizard" that can make intelligent guesses based on drawings, perfect for the game [Sketch Wizards](https://noceg43.github.io/sketchWizardWEB). The library is fully implemented in Dart, with crucial data files generated using Python and its powerful machine learning tools, due to the current limitations of ML libraries in Dart.

## ✨ Features

- 🧙‍♂️ **Wizard Class**: Core class that drives the guess-making process based on input drawings.
- 📉 **PCA and KNN**: Utilizes Principal Component Analysis (PCA) for dimensionality reduction and k-Nearest Neighbors (KNN) for classification.
- 📂 **Pre-generated Data**: Integrates with data files created using Python, which provide the wizard with the necessary information for making predictions.
- 🛠 **Simple and Intuitive Workflow**: Designed to be easy to use with minimal setup, allowing you to quickly integrate drawing-based inference into your projects.


## 🚀 Usage

To use **SketchWizard**, create an instance of the Wizard class, load the necessary model data from pre-generated files, and use it to make guesses based on your drawings. The library is designed to streamline the process, making it straightforward to integrate intelligent drawing recognition into your application. Check the [Sketch Wizard repository](https://github.com/noceg43/SketchWizards) to read a correct implementation and workflow.

### 🛠 Workflow Overview

1. **Generate PCA and KNN Files**: Before using the library, generate the necessary data files using Python.
2. **Load Models**: Use the Wizard class to load these files and prepare the model.
3. **Make Predictions**: Input a drawing, and the wizard will provide a guess based on the trained model.


## 🔗 Repository

For more information, head over to the [SketchWizard GitHub repository](https://github.com/noceg43/SketchWizards).
