CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission
# Check that the student code has the correct file submitted
if [[ -e ListExamples.java ]]
then
  echo "ListExample Found" 
else
    echo "missing" >&2
  exit 1
fi

mkdir lib
cp ../lib/* ./lib/
cp ../*.java .

echo "Directory created"

javac -cp $CPATH *.java 2> javac-error.txt



# Check if compilation was successful
if [[ $? -ne 0 ]]
then
  cat javac-error.txt >&2
fi

echo "compiled"

# Run the tests and save the output to a file
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples

echo "test ran"
