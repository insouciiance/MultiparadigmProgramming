using System;
using System.IO;

namespace task2
{
    public class Program
    {
        public static void Main(string[] args)
        {
            string[] lines = File.ReadAllLines(args[0]);

            (string value, int count, int[] pages)[] wordOccurrences = Array.Empty<(string, int, int[])>();

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

                int occurrenceIndex = 0;

            occurrence_check:

                if (occurrenceIndex < wordOccurrences.Length && wordOccurrences[occurrenceIndex].value != word)
                {
                    occurrenceIndex++;
                    goto occurrence_check;
                }

                if (occurrenceIndex < wordOccurrences.Length)
                {
                    ref var wordOccurrence = ref wordOccurrences[occurrenceIndex];
                    wordOccurrence.count++;
                    int currentPageNumber = lineIndex / 45 + 1;

                    bool pageExists = false;
                    int pageCheckIndex = 0;

                page_check:
                    if (pageCheckIndex >= wordOccurrence.pages.Length)
                    {
                        goto page_check_next;
                    }

                    if (currentPageNumber == wordOccurrence.pages[pageCheckIndex])
                    {
                        pageExists = true;
                        goto page_check_next;
                    }

                    pageCheckIndex++;

                    if (pageCheckIndex < wordOccurrence.pages.Length)
                    {
                        goto page_check;
                    }

                page_check_next:
                    if (!pageExists)
                    {
                        int[] newPages = new int[wordOccurrence.pages.Length + 1];
                        int newPagesIndex = 0;

                    add_page:

                        if (newPagesIndex >= wordOccurrence.pages.Length)
                        {
                            goto add_new_page;
                        }

                        newPages[newPagesIndex] = wordOccurrence.pages[newPagesIndex];

                        newPagesIndex++;

                        if (newPagesIndex < wordOccurrence.pages.Length)
                        {
                            goto add_page;
                        }

                    add_new_page:
                        newPages[^1] = currentPageNumber;
                        wordOccurrence.pages = newPages;
                    }
                }
                else
                {
                    (string, int, int[])[] newOccurrences = new (string, int, int[])[wordOccurrences.Length + 1];

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

                    newOccurrences[newOccurrencesIndex] = (word, 1, new[] { lineIndex / 45 + 1 });

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

            int wordCompareIndex = 0;
            bool shouldSwap = false;
            int minLength = curr.value.Length > next.value.Length ? next.value.Length : curr.value.Length;

            word_compare:

            if (wordCompareIndex >= minLength)
            {
                goto word_compare_end;
            }

            char currChar = curr.value[wordCompareIndex];
            char nextChar = next.value[wordCompareIndex];

            if (currChar > nextChar)
            {
                shouldSwap = true;
                goto word_compare_end;
            }

            if (currChar < nextChar)
            {
                goto word_compare_end;
            }

            wordCompareIndex++;

            if (wordCompareIndex < curr.value.Length || wordCompareIndex < next.value.Length)
            {
                goto word_compare;
            }

        word_compare_end:

            if (!shouldSwap && wordCompareIndex == minLength && curr.value.Length > next.value.Length)
            {
                shouldSwap = true;
            }

            if (shouldSwap)
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

            if (occurrence.count >= 100)
            {
                goto writer_loop_end;
            }

            string pagesString = string.Empty;

            int currentPageIndex = 0;

            page_string_loop:

            if (currentPageIndex >= occurrence.pages.Length)
            {
                goto write_pages;
            }

            pagesString += $"{occurrence.pages[currentPageIndex]}";

            if (currentPageIndex < occurrence.pages.Length - 1)
            {
                pagesString += ", ";
            }

            currentPageIndex++;

            if (currentPageIndex < occurrence.pages.Length)
            {
                goto page_string_loop;
            }

            write_pages:

            writer.WriteLine($"{occurrence.value} - {pagesString}");

        writer_loop_end:

            occurrence_index++;

            if (occurrence_index < wordOccurrences.Length)
            {
                goto writer_loop;
            }
        }
    }
}