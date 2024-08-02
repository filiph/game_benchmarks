using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MusicPlay : MonoBehaviour
{
    public AudioSource music;

    void Start()
    {
        music.Play();
    }

    public void ToggleAudioOn()
    {
        if (music.isPlaying)
        {
            music.Pause();
        } else
        {
            music.UnPause();
        }
    }
}
