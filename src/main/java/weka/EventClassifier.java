package weka;

import weka.classifiers.trees.J48;
import weka.classifiers.Evaluation;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.StringToWordVector;

import java.util.Random;

public class EventClassifier {
    public static void main(String[] args) {
        try {
            // Load dataset
            DataSource source = new DataSource("events.arff");
            Instances dataset = source.getDataSet();

            // Set class index (last attribute is the class label)
            dataset.setClassIndex(dataset.numAttributes() - 1);

            // Apply StringToWordVector to convert 'description' into numerical attributes
            StringToWordVector filter = new StringToWordVector();
            filter.setInputFormat(dataset);
            Instances filteredData = Filter.useFilter(dataset, filter);

            // Split data into training (80%) and testing (20%) sets
            int trainSize = (int) Math.round(filteredData.numInstances() * 0.8);
            int testSize = filteredData.numInstances() - trainSize;
            filteredData.randomize(new Random(1)); // Shuffle dataset

            Instances trainData = new Instances(filteredData, 0, trainSize);
            Instances testData = new Instances(filteredData, trainSize, testSize);

            // Train J48 Decision Tree
            J48 tree = new J48();
            tree.buildClassifier(trainData);

            // Evaluate model on test data
            Evaluation eval = new Evaluation(trainData);
            eval.evaluateModel(tree, testData);

            // Print results
            System.out.println("Trained J48 Decision Tree:\n" + tree);
            System.out.println("\n=== Evaluation Metrics ===");
            System.out.println(eval.toSummaryString());
            System.out.println("\n=== Confusion Matrix ===");
            System.out.println(eval.toMatrixString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
