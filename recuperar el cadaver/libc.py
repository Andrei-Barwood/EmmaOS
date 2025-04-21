from music21 import converter

def convert_musicxml_to_midi(input_path, output_path):
    """
    Convierte un archivo MusicXML a MIDI utilizando music21.
    
    :param input_path: Ruta del archivo de entrada (.musicxml o .xml)
    :param output_path: Ruta del archivo de salida (.midi)
    """
    try:
        # Leer el archivo MusicXML
        score = converter.parse(input_path)
        print("Archivo MusicXML cargado correctamente.")

        # Exportar a formato MIDI
        score.write('midi', fp=output_path)
        print(f"Archivo MIDI exportado a: {output_path}")
    except Exception as e:
        print(f"Error durante la conversión: {e}")

# Rutas de ejemplo
input_musicxml = "libc.musicxml"  # Archivo MusicXML generado por Audiveris
output_midi = "c.midi"       # Archivo MIDI de salida

# Realizar la conversión
convert_musicxml_to_midi(input_musicxml, output_midi)
