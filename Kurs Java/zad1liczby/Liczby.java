public class Liczby {
    private static final String[] jednosci = {
            null, "jeden", "dwa", "trzy", "cztery", "pięć",
            "sześć", "siedem", "osiem", "dziewięć"
    };
    private static final String[] nastki = {
            "dziesięć", "jedenaście", "dwanaście", "trzynaście",
            "czternaście", "piętnaście", "szesnaście",
            "siedemnaście", "osiemnaście", "dziewiętnaście"
    };
    private static final String[] dziesiatki = {
            null, null, "dwadzieścia", "trzydzieści",
            "czterdzieści", "pięćdziesiąt", "sześćdziesiąt",
            "siedemdziesiąt", "osiemdziesiąt", "dziewięćdziesiąt"
    };
    private static final String[] setki = {
            null, "sto", "dwieście", "trzysta",
            "czterysta", "pięćset", "sześćset",
            "siedemset", "osiemset", "dziewięćset"
    };

    private static String getSuffix(int count, boolean isThousand) {
        return switch (count % 10) {
            case 1 -> (count % 100 == 11) ? (isThousand ? "tysięcy" : "milionów") : (isThousand ? "tysiąc" : "milion");
            case 2, 3, 4 -> (count % 100 >= 12 && count % 100 <= 14) ?
                    (isThousand ? "tysięcy" : "milionów") : (isThousand ? "tysiące" : "miliony");
            default -> isThousand ? "tysięcy" : "milionów";
        };
    }

    private static String convertToWords(int number) {
        if (number == 0) return "zero";
        if (number == Integer.MIN_VALUE) {
            return "minus dwa miliardy sto czterdzieści siedem milionów czterysta osiemdziesiąt trzy tysiące sześćset czterdzieści osiem";
        }
        if (number < 0) {
            return "minus " + convertToWords(-number);
        }
        StringBuilder words = new StringBuilder();

        if (number >= 1_000_000_000) {
            if (number / 1_000_000_000 == 1) {
                words.append("miliard").append(" ");
            } else {
                words.append("dwa miliardy").append(" ");
            }
            number %= 1_000_000_000;
        }
        if (number >= 1_000_000) {
            if (number / 1_000_000 == 1) {
                words.append(getSuffix(number / 1_000_000, false)).append(" ");
            } else {
                words.append(convertToWords(number / 1_000_000)).append(" ")
                        .append(getSuffix(number / 1_000_000, false)).append(" ");
            }
            number %= 1_000_000;
        }
        if (number >= 1_000) {
            if (number / 1_000 == 1) {
                words.append(getSuffix(number / 1_000, true)).append(" ");
            } else {
                words.append(convertToWords(number / 1_000)).append(" ")
                        .append(getSuffix(number / 1_000, true)).append(" ");
            }
            number %= 1_000;
        }
        if (number >= 100) {
            words.append(setki[number / 100]).append(" ");
            number %= 100;
        }
        if (number >= 20) {
            words.append(dziesiatki[number / 10]).append(" ");
            number %= 10;
        } else if (number >= 10) {
            words.append(nastki[number - 10]).append(" ");
            return words.toString().trim();
        }
        if (number > 0) {
            words.append(jednosci[number]).append(" ");
        }

        return words.toString().trim();
    }

    public static void main(String[] args) {
        for (String arg : args) {
            try {
                int number = Integer.parseInt(arg);
                System.out.println(convertToWords(number));
            } catch (NumberFormatException e) {
                System.out.println("Błąd: niepoprawny format liczby '" + arg + "'");
            }
        }
    }
}
