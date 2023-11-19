import 'package:flutter/material.dart';
import 'package:reto10/models/db_entry.dart';

class Legend extends StatelessWidget {
  const Legend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final avantelStr = supplierValues.reverse[Supplier.AVANTEL_S_A_S];
    final colombiaMovilStr =
        supplierValues.reverse[Supplier.COLOMBIA_MOVIL_S_A_ESP];
    final colombiaTelecomStr =
        supplierValues.reverse[Supplier.COLOMBIA_TELECOMUNICACIONES_S_A_E_S_P];
    final comunicacionCelStr =
        supplierValues.reverse[Supplier.COMUNICACION_CELULAR_S_A_COMCEL_S_A];
    final empresaTelecomStr = supplierValues
        .reverse[Supplier.EMPRESA_DE_TELECOMUNICACIONES_DE_BOGOTA_S_A_ESP];
    final partnersStr =
        supplierValues.reverse[Supplier.PARTNERS_TELECOM_COLOMBIA_SAS];
    final virginStr =
        supplierValues.reverse[Supplier.VIRGIN_MOBILE_COLOMBIA_S_A_S];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'A = $avantelStr',
          style: textTheme.labelSmall,
          textAlign: TextAlign.start,
        ),
        Text(
          'B = $colombiaMovilStr',
          style: textTheme.labelSmall,
        ),
        Text(
          'C = $colombiaTelecomStr',
          style: textTheme.labelSmall,
        ),
        Text(
          'D = $comunicacionCelStr',
          style: textTheme.labelSmall,
        ),
        Text(
          'E = $empresaTelecomStr',
          style: textTheme.labelSmall,
        ),
        Text(
          'F = $partnersStr',
          style: textTheme.labelSmall,
        ),
        Text(
          'G = $virginStr',
          style: textTheme.labelSmall,
        ),
      ],
    );
  }
}
