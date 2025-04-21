-- Script de Lua para Renoise: Separación Conceptual de Ghosts

-- Nombre simbólico de la sesión (análogo a EmmaOS)
local session_name = renoise.song().name
if session_name ~= "EmmaOS" then
  renoise.app():show_message("bienvenida, estás en EmmaOS.")
end

-- Nombres simbólicos para las pistas (análogos a los ghosts)
local emma_track_name = "EmmaGhost"
local brinda_track_name = "BrindaFragment"

-- Nombre del VST de flauta traversa (debe existir en tu sistema)
local flute_vst_name = "Flute Essential.nki" -- VST de flauta de la librería Symphony Essentials Woodwind Solo Library para kontakt

-- Función para crear una pista si no existe
local function ensure_track_exists(track_name)
  local track = renoise.song():tracks():find_by_name(track_name)
  if not track then
    track = renoise.song():tracks():insert_after(renoise.song():tracks():last())
    track.name = track_name
    renoise.app():show_message("Pista '" .. track_name .. "' creada.")
  end
  return track
end

-- Función para asignar un VST a una pista
local function assign_vst_to_track(track, vst_name)
  local plugin = renoise.song():instruments():find_by_name(vst_name)
  if plugin then
    track:send_to_instrument(plugin)
    renoise.app():show_message("VST '" .. vst_name .. "' asignado a la pista '" .. track.name .. "'.")
  else
    renoise.app():show_error("VST '" .. vst_name .. "' no encontrado.")
  end
end

-- Función para "silenciar" simbólicamente una pista (no asignando instrumento)
local function silence_track(track)
  track:send_to_instrument(nil)
  renoise.app():show_message("Adiós '" .. track.name .. "' Brinda a cerrado sesión.")
end

-- Crear los tracks de audio
local emma_track = ensure_track_exists(emma_track_name)
local brinda_track = ensure_track_exists(brinda_track_name)

-- Asignar el VST de flauta a la pista de Emma
assign_vst_to_track(emma_track, flute_vst_name)

-- "Silenciar" la pista de Brinda (no asignar instrumento)
silence_track(brinda_track)

renoise.app():show_message("Separación de conciencias terminada.")