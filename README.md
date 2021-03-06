# High-pass-IIR-Filter-5-th-order-
Данный репозиторий содержит файлы для всех этапов реализации интегральной схемы цифрового БИХ-ФВЧ Фильтра 5-го порядка в фиксированной точности. 

Характеристики реализуемого цифрового фильтра: 
1. Разрядность входного и выходного сигналов - 15 
2. Граница полосы пропускания - 0,9
3. Граница полосы задерживания - 0,8
4. Подавление в полосе задерживания - 60 дБ
5. Величина неравномерности в полосе пропускания - 0,3 дБ
6. Минимальность порядка
7. Оптимальность разрядности регистров

Описание файлов, представленных в данном репозитории, приведено в таблице ниже.

Название файла| Описание файла
-------------|-------------
Elliptic.v| Описание фильтра на языке Verilog HDL
Elliptic_tb.v| Описание тестового модуля для верификации Verilog-описания фильтра и списка логических вентилей и межсоединений после логического синтеза с привязкой к технологической библиотеке
Elliptic_tb_Last_Sim.v| Описание тестового модуля для верификации полученного списка логических вентилей и межсоединений после генерации топологии
Input_rsvd.dat| Набор тестовых векторов фильтра для 15 опорных сигналов (3 частот: 5, 8 и 9 кГц; 5 амплитуд: 1, 8, 64, 256, 1023) при дискретизации частотой в 20 кГц
Output_rsvd_expected.dat| Набор опорных значений, ожидамых на выходе фильтра при наличи на входе предыдущего набора тестовых векторов
X-FAB_typ.tcl| Скрипт с указанием путей к технологической библиотеке ячеек для typical corner
X-FAB_slow.tcl| Скрипт с указанием путей к технологической библиотеке ячеек для slow corner
X-FAB_fast.tcl| Скрипт с указанием путей к технологической библиотеке ячеек для fast corner
Elliptic.sdc| Файл, содержащий временные ограничения для проекта (для определения временных ограничений на этапе логического синтеза и для генерации топологии)
Elliptic_25.sdc| Файл, содержащий временные ограничения для проекта (для логического синтеза оптимального нетлиста)
Elliptic_synth.tcl| Скрипт для осуществления логического синтеза в случае typical corner
Elliptic_synth_25.tcl| Скрипт для осуществления логического синтеза в случае typical corner (оптимальный вариант нетлиста) 
Elliptic_synth_slow.tcl| Скрипт для осуществления логического синтеза в случае slow corner
Elliptic_synth_fast.tcl| Скрипт для осуществления логического синтеза в случае fast corner
Elliptic_IO| Файл с привязкой и расстановкой пинов
MMMC.tcl| Скрипт для генерации топологии, содержащий информацию о технологической библиотеке и включающий информацию о временных ограничениях проекта
Elliptic_PaR.tcl| Скрипт для автоматической генерации топологии 

Для создания топологии цифровой интегральной схемы цифрового устройства необходимо пройти три основных этапа:

1. описание устройства на поведенческом уровне (к примеру, на языке Verilog HDL);
2. логический синтез устройства с привязкой к технологической библиотеке;
3. генерация топологии из полученного на предыдущем этапе списка логических вентилей и межсоединений.

Для того, чтобы собрать данный проект, требуется:
1. скачать папку Source, проверить, находятся ли в ней файлы "Elliptic.v", "Elliptic.sdc", "Elliptic_25.sdc", "Input_rsvd.dat", "Output_rsvd.dat", "Elliptic_tb.v", "Elliptic_IO";
2. скачать папку Scripts, проверить, находятся ли в ней скрипты "X-FAB_typ.tcl", "X-FAB_slow.tcl", "X-FAB_fast.tcl", "Elliptic_synth.tcl", "Elliptic_synth_25.tcl", "Elliptic_synth_slow.tcl", "Elliptic_synth_fast.tcl", "MMMC.tcl", "Elliptic_PaR.tcl", в скриптах "X-FAB_typ.tcl", "X-FAB_slow.tcl", "X-FAB_fast.tcl", "MMMC.tcl" переписать пути к файлам технологической библиотеки в соответствии с их расположением в Вашем случае;
3. создать папку, из которой будет запущен САПР для произведения логического синтеза, в данной работе использовался Cadence RTL Compiler;
4. запустить САПР со скрипта "Elliptic_synth_25.tcl";
5. для проверки временных отчетов для typical, slow и fast corners требуется создать папки для запуска из них САПР со скриптов "Elliptic_synth.tcl", "Elliptic_synth_slow.tcl" и "Elliptic_synth_fast.tcl" соответственно;
6. для генерации топологии требуется проверить, что в созданной автоматически после логического синтеза папке Outputs находится файл "Elliptic_synth.v";
7. создать папку, из которой будет запущен САПР для генерации топологии, в данной работе использовался Cadence Encounter;
8. запустить САПР со скрипта "Elliptic_PaR.tcl";
9. проверить наличие в папке Outputs сгенерированных файлов "Top_netlist.v" (для моделирования), "Physical_netlist.v", "Elliptiс.def" (для импорта в САПР, если это потребуется, где будет осуществляться DRC- и LVS-верификации, в данной работе это осуществлялось в САПР Cadence Virtuoso), "Elliptic_MAX.sdf", "Elliptic_MIN.sdf" (для моделирования с учетом влияния эффектов, полученных при генерации топологии);

После этапов логического синтеза и генерации топологии следует провести функциональную верификацию, чтобы убедиться в функциональной корректности работы устройства. Для проверки функциональной корректности Verilog-описания и списка логических вентилей и межсоединений после логического синтеза следует использовать файл Elliptic_tb.v. Для моделирования после этапа генерации топологии следует использовать файл Elliptic_tb_Last_Sim.v. В сгенерированные файлы списков логических вентилей и межсоединений нужно добавить timescale.

ВАЖНО: постоянно (на этапах логического синтеза и генерации топологии) следить за результатами статического временного анализа и других проверок в генерируемых отчетах.
