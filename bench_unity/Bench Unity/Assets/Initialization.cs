using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class Initialization : MonoBehaviour
{
    public GameObject disappearingButton;
    public GameObject canvas;

    void Start()
    {
        CreateDisappearingButtons();
    }

    void CreateDisappearingButtons()
    {
        for (var i = 0; i < 20; i++)
        {
            var disBtn = Instantiate(disappearingButton, new Vector3(1000, 700 - i * 22, 0), Quaternion.identity, canvas.transform);
            var buttonText = disBtn.GetComponentInChildren<TextMeshProUGUI>();
            buttonText.text = $"Button {i + 1}";
        }
    }
}
