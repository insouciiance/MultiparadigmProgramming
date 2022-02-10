using System;
using System.IO;

namespace task1
{
    public class Program
    {
        public static void Main(string[] args)
        {
            string[] lines = File.ReadAllLines(args[0]);

            string[] stopWords =
            {
                "i", "me", "my", "myself", "we", "our", "ours", "ourselves", "you", "your", "yours", "yourself", "yourselves", "he", "him", "his", "himself", "she", "her", "hers", "herself", "it", "its", "itself", "they", "them", "their", "theirs", "themselves", "what", "which", "who", "whom", "this", "that", "these", "those", "am", "is", "are", "was", "were", "be", "been", "being", "have", "has", "had", "having", "do", "does", "did", "doing", "a", "an", "the", "and", "but", "if", "or", "because", "as", "until", "while", "of", "at", "by", "for", "with", "about", "against", "between", "into", "through", "during", "before", "after", "above", "below", "to", "from", "up", "down", "in", "out", "on", "off", "over", "under", "again", "further", "then", "once", "here", "there", "when", "where", "why", "how", "all", "any", "both", "each", "few", "more", "most", "other", "some", "such", "no", "nor", "not", "only", "own", "same", "so", "than", "too", "very", "s", "t", "can", "will", "just", "don", "should", "now"
            };

            (string value, int count)[] wordOccurrences = Array.Empty<(string, int)>();
            
            int lineIndex = 0;

        lines_loop:
            if (lines.Length == 0)
            {
                goto bubble_sort;
            }

            string currentLine = lines[lineIndex];
            currentLine += ' ';

            int charIndex = 0;

            int wordStartIndex = 0;

        line_loop:
            if (currentLine.Length <= 1)
            {
                goto line_loop_end;
            }

            char currentChar = currentLine[charIndex];

            if (currentChar is ' ')
            {
                string word = "";

                int wordCharIndex = wordStartIndex;

            word_copy:

                char? currentWordChar = currentLine[wordCharIndex];

                if (currentWordChar is >= 'A' and <= 'Z')
                {
                    currentWordChar = (char)(currentWordChar + 32);
                }

                if (currentWordChar is < 'a' or > 'z')
                {
                    currentWordChar = null;
                }

                word += currentWordChar;

                wordCharIndex++;

                if (wordCharIndex < charIndex)
                {
                    goto word_copy;
                }

                if (word == string.Empty)
                {
                    goto line_loop_end;
                }

                int stopWordIndex = 0;

            stopword_check:

                string stopWord = stopWords[stopWordIndex];

                if (stopWord == word)
                {
                    wordStartIndex = charIndex + 1;
                    goto line_loop_end;
                }

                stopWordIndex++;

                if (stopWordIndex < stopWords.Length)
                {
                    goto stopword_check;
                }

                int occurrenceIndex = 0;

            occurrence_check:

                if (occurrenceIndex < wordOccurrences.Length && wordOccurrences[occurrenceIndex].value != word)
                {
                    occurrenceIndex++;
                    goto occurrence_check;
                }

                if (occurrenceIndex < wordOccurrences.Length)
                {
                    wordOccurrences[occurrenceIndex].count++;
                }
                else
                {
                    (string, int)[] newOccurrences = new (string, int)[wordOccurrences.Length + 1];

                    int newOccurrencesIndex = 0;

                newOccurrences_loop:
                    if (newOccurrencesIndex >= wordOccurrences.Length)
                    {
                        goto newOccurrenceAdd;
                    }

                    newOccurrences[newOccurrencesIndex] = wordOccurrences[newOccurrencesIndex];
                    newOccurrencesIndex++;

                    if (newOccurrencesIndex < wordOccurrences.Length)
                    {
                        goto newOccurrences_loop;
                    }

                newOccurrenceAdd:

                    newOccurrences[newOccurrencesIndex] = (word, 1);

                    wordOccurrences = newOccurrences;
                }

                wordStartIndex = charIndex + 1;
            }

        line_loop_end:

            charIndex++;

            if (charIndex < currentLine.Length)
            {
                goto line_loop;
            }

            lineIndex++;

            if (lineIndex < lines.Length)
            {
                goto lines_loop;
            }

        bubble_sort:

            int i = 0;
            int j = 0;

        outer_sort:

        inner_sort:

            if (j >= wordOccurrences.Length - 1)
            {
                goto inner_loop_end;
            }

            var curr = wordOccurrences[j];
            var next = wordOccurrences[j + 1];

            if (curr.count < next.count)
            {
                wordOccurrences[j + 1] = curr;
                wordOccurrences[j] = next;
            }

        inner_loop_end:

            j++;

            if (j < wordOccurrences.Length - 1)
            {
                goto inner_sort;
            }

            j = 0;
            i++;

            if (i < wordOccurrences.Length - 1)
            {
                goto outer_sort;
            }

            using StreamWriter writer = new("occurrences.txt");
            int occurrence_index = 0;

        writer_loop:
            if (occurrence_index >= wordOccurrences.Length)
            {
                goto writer_loop_end;
            }

            var occurrence = wordOccurrences[occurrence_index];

            writer.WriteLine($"{occurrence.value} {occurrence.count}");

        writer_loop_end:

            occurrence_index++;

            if (occurrence_index < wordOccurrences.Length && occurrence_index < 25)
            {
                goto writer_loop;
            }
        }
    }
}